
// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/controller/db/pg_property_services.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class PgFormProvider extends ChangeNotifier {
  final PgPropertyServices _pgPropertyServices = PgPropertyServices();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  

  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phonenumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutcontroller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();

  String? documentId; // For updating existing properties
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
  String food = ''; // Renamed from foodavailblity
  String bedroom = '';
  String bathroom = '';
  List<Map<String, dynamic>> selectedAmenities = [];

  List<String> get selectedAmenitiesList =>
      selectedAmenities.map((amenity) => amenity['name'] as String).toList();

  void setName(String value) {
    name = value;
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

  void setLocation(String value) {
    location = value;
    notifyListeners();
  }

  void setPhotoPath(List<String> path) {
    photoPath = path;
    notifyListeners();
  }

  void setPropertyType(String value) {
    propertyType = value;
    notifyListeners();
  }

  void setAmenities(List<Map<String, dynamic>> amenities) {
    selectedAmenities = amenities;
    notifyListeners();
  }

  void setFood(String value) {
    food = value;
    notifyListeners();
  }

  void setBathroom(String value) {
    bathroom = value;
    notifyListeners();
  }

  void setBedroom(String value) {
    bedroom = value;
    notifyListeners();
  }

   bool isInitialized = false;
final formKey = GlobalKey<FormState>(); 

  void initializeFromProperty(PropertycardFormModel property) {
    documentId = property.id;
    nameController.text = property.name;
    propertyType = property.propertyType;
    photoPath = property.photoPath;
    location = property.location;
    locationController.text = property.location;
    phonenumController.text = property.phoneNumber;
    emailController.text = property.email;
    aboutcontroller.text = property.about;
    amountcontroller.text = property.amount;
    furnished = property.furnished;
    powerbackup = property.powerbackup;
    food = property.food ?? '';
    bedroom = property.bedroom;
    bathroom = property.bathroom;
    selectedAmenities = property.amenities;
    notifyListeners();
  }

  Future<void> addtodb(BuildContext context) async {
    try {
      log('Bedroom: $bedroom, Bathroom: $bathroom');

      // Validate required fields
      if (name.isEmpty ||
          propertyType.isEmpty ||
          location.isEmpty ||
          phoneNumber.isEmpty ||
          email.isEmpty ||
          amount.isEmpty ||
          bedroom.isEmpty ||
          bathroom.isEmpty ||
          int.parse(bedroom) <= 0 ||
          int.parse(bathroom) <= 0) {
        throw Exception("All required fields must be filled, and bedroom/bathroom must be greater than 0");
      }

      final pgData = PropertycardFormModel(
        id: documentId.toString(),
        name: name,
        propertyType: propertyType,
        photoPath: photoPath,
        location: location,
        phoneNumber: phoneNumber,
        email: email,
        about: about,
        amount: amount,
        furnished: furnished,
        powerbackup: powerbackup,
        food: food,
        bedroom: bedroom,
        bathroom: bathroom,
        amenities: selectedAmenities,
      );

      if (documentId == null) {
        // Add new property
        await _pgPropertyServices.addPgProperty(pgData);
      } else {
        // Update existing property
        await _pgPropertyServices.updatePgProperty(documentId!, pgData);
      }

      // Clear form
      clearForm();
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(documentId == null ? "PG property added successfully" : "PG property updated successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      debugPrint('Error adding/updating PG property: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to ${documentId == null ? 'add' : 'update'} PG property: $e"),
          backgroundColor: Colors.red,
        ),
      );
      rethrow;
    }
  }Future<void> update(String id) async {
  log("Updating document with ID: $id");

  try {
    final docRef = FirebaseFirestore.instance.collection('pg_property').doc(id);

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
      'food': food, 
      'amenities': selectedAmenities,
      'bedroom': bedroom,
      'bathroom': bathroom,
    });

    log('Update successful for $id');
  } catch (e) {
    log('Error updating Firestore: $e');
    rethrow;
  }

  notifyListeners();
}

  void resetForm() {
    nameController.clear();
    phonenumController.clear();
    emailController.clear();
    aboutcontroller.clear();
    amountcontroller.clear();
    _isLoading = false;
    notifyListeners();
  }

  void clearForm() {
    nameController.clear();
    locationController.clear();
    phonenumController.clear();
    emailController.clear();
    aboutcontroller.clear();
    amountcontroller.clear();
    documentId = null;
    name = '';
    propertyType = '';
    photoPath = [];
    location = '';
    phoneNumber = '';
    email = '';
    about = '';
    amount = '';
    furnished = '';
    powerbackup = '';
    food = '';
    bedroom = '';
    bathroom = '';
    selectedAmenities = [];
  }

  void disposeControllers() {
    nameController.dispose();
    locationController.dispose();
    phonenumController.dispose();
    emailController.dispose();
    aboutcontroller.dispose();
    amountcontroller.dispose();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }
    Future<void> deleteRentalDataById(String documentId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      await db.collection('pg_property').doc(documentId).delete();
      log('Pg data deleted successfully');
    } catch (e) {
      log('Error deleting Pg data: $e');
    }
  }

}