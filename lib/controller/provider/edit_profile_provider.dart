import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:service_provider/controller/db/auth_database_service.dart';
import 'package:service_provider/model/signup_model.dart';

class EditProfileProvider extends ChangeNotifier {
  // --------------------- SERVICES ---------------------
  final AuthDatabaseService _dbService = AuthDatabaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();

  // --------------------- CONTROLLERS ---------------------
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  // --------------------- IMAGE ---------------------
  File? pickedImage;

  // --------------------- CLOUDINARY ---------------------
  final String cloudName = "ditqrbrs1";
  final String uploadPreset = "user_profile";

  bool isLoading = false;

  // --------------------- INIT ---------------------
  void init(SignUpModel user) {
    nameController = TextEditingController(text: user.username);
    phoneController = TextEditingController(text: user.phone);
    emailController = TextEditingController(text: user.email);
  }

  // --------------------- PICK IMAGE ---------------------
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (file != null) {
        pickedImage = File(file.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Image pick error: $e");
    }
  }

  void removeImage() {
    pickedImage = null;
    notifyListeners();
  }

  // --------------------- CLOUDINARY UPLOAD ---------------------
  Future<String?> uploadToCloudinary() async {
    if (pickedImage == null) return null;

    try {
      final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
      );

      final request = http.MultipartRequest("POST", url)
        ..fields["upload_preset"] = uploadPreset
        ..files.add(
          await http.MultipartFile.fromPath("file", pickedImage!.path),
        );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);

      if (response.statusCode == 200) {
        return data["secure_url"];
      }
    } catch (e) {
      debugPrint("Cloudinary upload error: $e");
    }
    return null;
  }

  // --------------------- UPDATE PROFILE ---------------------
  Future<void> updateProfile(BuildContext context) async {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name cannot be empty")),
      );
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) throw Exception("User not logged in");

      String? imageUrl;
      if (pickedImage != null) {
        imageUrl = await uploadToCloudinary();
      }

      await _dbService.updateUser(
        uid: uid,
        username: nameController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        profileImage: imageUrl,
      );

      pickedImage = null;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully")),
      );

      Navigator.pop(context);
    } catch (e) {
      debugPrint("Edit profile error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  // --------------------- LOAD USER DATA ---------------------
  Future<void> loadUserData() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection("service_provider")
          .doc(user.uid)
          .get();

      if (doc.exists) {
        nameController.text = doc["username"] ?? "";
        phoneController.text = doc["phone"] ?? "";
        emailController.text = doc["email"] ?? "";
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Load profile error: $e");
    }
  }

  // --------------------- DISPOSE ---------------------
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
