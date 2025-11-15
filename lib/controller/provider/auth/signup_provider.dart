import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:service_provider/controller/db/auth_database_service.dart';
import 'package:service_provider/controller/db/auth_service.dart';
import 'package:service_provider/model/signup_model.dart';
import 'package:service_provider/view/screen/login/login_screen.dart';

class SignUpProvider extends ChangeNotifier {

// --------------------- USER DATA ---------------------
  String username = "";
  String email = "";
  String phone = "";
  String? profileImageUrl;

// --------------------- CONTROLLERS ---------------------
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

// --------------------- IMAGE PICKER ---------------------
  File? pickedImage;
  final ImagePicker picker = ImagePicker();

// --------------------- SERVICES ---------------------
  final AuthService _authService = AuthService();
  final AuthDatabaseService _dbService = AuthDatabaseService();

// --------------------- CLOUDINARY ---------------------
  final String cloudName = "ditqrbrs1";
  final String uploadPreset = "user_profile";

// --------------------- PASSWORD VISIBILITY ---------------------
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

// --------------------- VALIDATION ---------------------
  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) return "Username required";
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return "Email required";
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return "Invalid email";
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return "Phone number required";
    if (value.length < 10) return "Enter valid phone number";
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password required";
    if (value.length < 6) return "Minimum 6 characters";
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return "Confirm password";
    if (value != passwordController.text) return "Passwords do not match";
    return null;
  }

// --------------------- PICK IMAGE ---------------------
  Future<void> pickImage(ImageSource source) async {
    try {
      final file = await picker.pickImage(source: source, imageQuality: 80);
      if (file != null) {
        pickedImage = File(file.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Image Error: $e");
    }
  }

// --------------------- CLOUDINARY UPLOAD ---------------------
  Future<String?> uploadToCloudinary() async {
    if (pickedImage == null) return null;

    try {
      final url = Uri.parse(
          "https://api.cloudinary.com/v1_1/$cloudName/image/upload");

      var request = http.MultipartRequest("POST", url)
        ..fields["upload_preset"] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath("file", pickedImage!.path));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var data = json.decode(responseBody);

      if (response.statusCode == 200) {
        return data["secure_url"];
      }
    } catch (e) {
      debugPrint("Cloudinary Upload Error: $e");
    }
    return null;
  }

// --------------------- SUBMIT FORM ---------------------
  Future<void> submitForm(BuildContext context) async {
    try {
      String? uploadedImageUrl = await uploadToCloudinary();

      UserCredential userCred = await _authService.register(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      String uid = userCred.user!.uid;

      SignUpModel user = SignUpModel(
        uid: uid,
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        profileImage: uploadedImageUrl,
        createdAt: DateTime.now(),
      );

      await _dbService.saveUser(user);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup Successful!"), backgroundColor: Colors.green),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );

      usernameController.clear();
      emailController.clear();
      phoneController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      pickedImage = null;

      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

// --------------------- FETCH USER DATA (PROFILE) ---------------------
  Future<void> loadUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("service_provider")
          .doc(user.uid)
          .get();

      if (doc.exists) {
        username = doc["username"] ?? "";
        email = doc["email"] ?? "";
        phone = doc["phone"] ?? "";
        profileImageUrl = doc["profileImage"];
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error loading profile: $e");
    }
  }

  // --------------------- UPDATE PROFILE IMAGE ---------------------
Future<void> updateProfileImage(BuildContext context) async {
  if (pickedImage == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("No image selected")),
    );
    return;
  }

  try {
    // Upload to Cloudinary
    String? newImageUrl = await uploadToCloudinary();
    if (newImageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Image upload failed")),
      );
      return;
    }

    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Update Firestore
    await FirebaseFirestore.instance
        .collection("service_provider")
        .doc(user.uid)
        .update({"profileImage": newImageUrl});

    // Update provider values
    profileImageUrl = newImageUrl;
    pickedImage = null;

    notifyListeners();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile photo updated successfully")),
    );

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error updating photo: $e")),
    );
  }
}

}
