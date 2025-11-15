import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class SellFormProvider extends ChangeNotifier {
  // 🧩 Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phonenumController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // 🔧 Variables
  bool isLoading = false;
  bool isInitialized = false;

  String? id = FirebaseAuth.instance.currentUser?.uid;
  String? documentId;

  String name = '';
  String propertyType = '';
  List<String> photoPath = [];
  String location = '';
  String phoneNumber = '';
  String email = '';
  String about = '';
  String amount = '';
  String furnished = '';
  String powerbackup = '';
  String constructionstatus = '';
  String bedroom = '';
  String bathroom = '';

  List<Map<String, dynamic>> selectedAmenities = [];

  final List<PropertycardFormModel> _properties = [];

  // 🔹 Getters
  List<PropertycardFormModel> get properties => _properties;

  List<String> get selectedAmenitiesList =>
      selectedAmenities.map((e) => e['name'] as String).toList();

  // 🔹 Firestore Stream for live updates
  Stream<PropertycardFormModel?> getPropertyStream(String id) {
    return FirebaseFirestore.instance
        .collection('sell_property')
        .doc(id)
        .snapshots()
        .map((doc) =>
            doc.exists ? PropertycardFormModel.fromJson(doc.data()!) : null);
  }

  // 🔹 Setters
  void setName(String value) {
    name = value;
    notifyListeners();
  }

  void setPropertyType(String value) {
    propertyType = value;
    notifyListeners();
  }

  void setPhotoPath(List<String> paths) {
    photoPath = paths;
    notifyListeners();
  }

  void setLocation(String value) {
    location = value;
    notifyListeners();
  }

  void setPhone(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setAbout(String value) {
    about = value;
    notifyListeners();
  }

  void setAmount(String value) {
    amount = value;
    notifyListeners();
  }

  void setFurnished(String value) {
    furnished = value;
    notifyListeners();
  }

  void setPowerbackup(String value) {
    powerbackup = value;
    notifyListeners();
  }

  void setConstructionStatus(String value) {
    constructionstatus = value;
    notifyListeners();
  }

  void setAmenities(List<Map<String, dynamic>> amenities) {
    selectedAmenities = amenities;
    notifyListeners();
  }

  void setBedroom(String value) {
    bedroom = value;
    notifyListeners();
  }

  void setBathroom(String value) {
    bathroom = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void resetForm() {
    nameController.clear();
    locationController.clear();
    phonenumController.clear();
    emailController.clear();
    aboutController.clear();
    amountController.clear();
    selectedAmenities.clear();
    isLoading = false;
    notifyListeners();
  }

  void disposeControllers() {
    nameController.dispose();
    locationController.dispose();
    phonenumController.dispose();
    emailController.dispose();
    aboutController.dispose();
    amountController.dispose();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  // 🧩 Initialize existing property (used for Edit)
  void initializeFromProperty(PropertycardFormModel property) {
    nameController.text = property.name;
    locationController.text = property.location;
    phonenumController.text = property.phoneNumber;
    emailController.text = property.email;
    aboutController.text = property.about;
    amountController.text = property.amount;

    name = property.name;
    propertyType = property.propertyType;
    photoPath = property.photoPath;
    location = property.location;
    phoneNumber = property.phoneNumber;
    email = property.email;
    about = property.about;
    amount = property.amount;
    bedroom = property.bedroom;
    bathroom = property.bathroom;
    furnished = property.furnished;
    powerbackup = property.powerbackup;
    selectedAmenities = property.amenities;
    constructionstatus = property.constructionstatus ?? '';

    isInitialized = true;
    notifyListeners();
  }

  // 🧠 Add new Sell Property to Firestore
  Future<void> addToDb(BuildContext context) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception("User not logged in");

      const collectionName = 'sell_property';
      setLoading(true);

      await FirebaseFirestore.instance.collection(collectionName).add({
        'uid': uid,
        'name': name,
        'propertyType': propertyType,
        'photoPath': photoPath,
        'location': location,
        'phoneNumber': phoneNumber,
        'email': email,
        'about': about,
        'amount': amount,
        'furnished': furnished,
        'powerbackup': powerbackup,
        'amenities': selectedAmenities,
        'bathroom': bathroom,
        'bedroom': bedroom,
        'constructionstatus': constructionstatus,
        'collectiontype': collectionName,
        'status': 'available',
        'timestamp': FieldValue.serverTimestamp(),
      });

      setLoading(false);
      log('Property added successfully!');
    } catch (e) {
      log('Error adding to Firestore: $e');
      setLoading(false);
      rethrow;
    }
  }

  // 🗑 Delete property by document ID
  Future<void> deleteSellPropertyById(String documentId) async {
    final db = FirebaseFirestore.instance;
    try {
      await db.collection('sell_property').doc(documentId).delete();
      log('Property deleted successfully');
    } catch (e) {
      log('Error deleting property: $e');
    }
  }

  // 🔄 Update property data
  Future<void> update(String id) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('sell_property').doc(id);

      await docRef.update({
        'name': name,
        'propertyType': propertyType,
        'photoPath': photoPath,
        'location': location,
        'phoneNumber': phoneNumber,
        'email': email,
        'about': about,
        'amount': amount,
        'furnished': furnished,
        'powerbackup': powerbackup,
        'amenities': selectedAmenities,
        'bedroom': bedroom,
        'bathroom': bathroom,
        'constructionstatus': constructionstatus,
      });

      log('Property updated successfully');
      notifyListeners();
    } catch (e) {
      log('Error updating property: $e');
      rethrow;
    }
  }
}
