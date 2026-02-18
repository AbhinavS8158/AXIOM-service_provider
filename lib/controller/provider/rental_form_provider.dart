import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/model/booking_model.dart';
import 'package:service_provider/model/propertycard_form_model.dart';

class RentalFormProvider extends ChangeNotifier {
  // --- Controllers ---
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phonenumController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController aboutcontroller = TextEditingController();
  final TextEditingController amountcontroller = TextEditingController();

  // --- State Variables ---
  bool _isLoading = false;
  bool get isLoading => _isLoading;

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
  List<Map<String, dynamic>> selectedAmenities = [];
  String bathroom = '';
  String bedroom = '';

  BookingModel? _currentBooking;
  BookingModel? get currentBooking => _currentBooking;

  final _collection = FirebaseFirestore.instance.collection('rent_property');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // --- Streams & Getters ---
  Stream<PropertycardFormModel?> getPropertyStream(String id) {
    return _collection.doc(id).snapshots().map((doc) {
      if (!doc.exists) return null;
      final data = doc.data()!;
      return PropertycardFormModel.fromJson({
        ...data,
        'id': doc.id,
      });
    });
  }

  // --- Setters ---
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setName(String value) {
    name = value;
    notifyListeners();
  }

  void setPropertyType(String type) {
    propertyType = type;
    notifyListeners();
  }

  void setPhotoPath(List<String> path) {
    photoPath = path;
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

  void setFurnished(String type) {
    furnished = type;
    notifyListeners();
  }

  void setPowerbackup(String type) {
    powerbackup = type;
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

  // --- Logic Functions ---
  bool isInitialized = false;
  final formKey = GlobalKey<FormState>();

  void initializeFromProperty(PropertycardFormModel property) {
    nameController.text = property.name;
    name = property.name;
    propertyType = property.propertyType;
    photoPath = property.photoPath;
    location = property.location;
    locationController.text = property.location;
    phonenumController.text = property.phoneNumber;
    phoneNumber = property.phoneNumber;
    emailController.text = property.email;
    email = property.email;
    aboutcontroller.text = property.about;
    about = property.about;
    amountcontroller.text = property.amount;
    amount = property.amount;
    bedroom = property.bedroom;
    bathroom = property.bathroom;
    furnished = property.furnished;
    powerbackup = property.powerbackup;
    selectedAmenities = property.amenities;

    isInitialized = true;
    notifyListeners();
  }

  Future<void> addtodb(BuildContext context) async {
    try {
      setLoading(true);
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception("User not logged in");

      const collectionName = 'rent_property';

      final property = PropertycardFormModel(
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
        bathroom: bathroom,
        bedroom: bedroom,
        amenities: selectedAmenities,
        status: 'available',
        collectiontype: collectionName,
      );

      final data = property.toJson()
        ..['uid'] = uid
        ..['timestamp'] = FieldValue.serverTimestamp();

      await _firestore.collection(collectionName).add(data);
      resetForm();
    } catch (e) {
      debugPrint('Error adding to Firestore: $e');
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteRentalDataById(String documentId) async {
    try {
      await _collection.doc(documentId).delete();
      log('Rental data deleted successfully');
    } catch (e) {
      log('Error deleting rental data: $e');
    }
  }

  Future<void> update(String id) async {
    try {
      setLoading(true);
      await _collection.doc(id).update({
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
        'status':"0",
        
      });
      notifyListeners();
    } finally {
      setLoading(false);
    }
  }




  // --- Clean Up ---
  void resetForm() {
    clearAllFields();
  }

  void clearAllFields() {
    nameController.clear();
    locationController.clear();
    phonenumController.clear();
    emailController.clear();
    aboutcontroller.clear();
    amountcontroller.clear();

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
    selectedAmenities = [];
    bathroom = '';
    bedroom = '';

    isInitialized = false;
    documentId = null;
    _currentBooking = null;
    _isLoading = false;

    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    phonenumController.dispose();
    emailController.dispose();
    aboutcontroller.dispose();
    amountcontroller.dispose();
    super.dispose();
  }
}
