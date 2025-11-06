import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class RentalFormProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phonenumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutcontroller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();

  bool isLoading =false;
  
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

Stream<PropertycardFormModel?> getPropertyStream(String id) {
  return FirebaseFirestore.instance
      .collection('properties')
      .doc(id)
      .snapshots()
      .map((doc) =>
          doc.exists ? PropertycardFormModel.fromJson(doc.data()!) : null);
}


final List<PropertycardFormModel> _properties = [];

  List<PropertycardFormModel> get properties => _properties;
  
  List<String> get selectedAmenitiesList =>
      selectedAmenities.map((amenity) => amenity['name'] as String).toList();

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
  PropertycardFormModel? getPropertyById(String id) {
    try {
      return _properties.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
 void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
   void resetForm() {
    nameController.clear();
    phonenumController.clear();
    emailController.clear();
    aboutcontroller.clear();
    amountcontroller.clear();
    isLoading = false;
    notifyListeners();
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

  bool isInitialized = false;
final formKey = GlobalKey<FormState>();

void initializeFromProperty(PropertycardFormModel property) {
  nameController.text = property.name;
  propertyType = property.propertyType;
  photoPath = property.photoPath;
  location = property.location;
  locationController.text = property.location;
  phonenumController.text = property.phoneNumber;
  emailController.text = property.email;
  aboutcontroller.text = property.about;
  amountcontroller.text = property.amount;
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
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) throw Exception("User not logged in");

    await FirebaseFirestore.instance.collection('rent_property').add({
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
      'selectedAmenities': selectedAmenities,
      'bathroom': bathroom,
      'bedroom': bedroom,
      'timestamp': FieldValue.serverTimestamp(),
    });
  } catch (e) {
    debugPrint('Error adding to Firestore: $e');
    rethrow;
  }
}

  /// ✅ DELETE FUNCTION
  Future<void> deleteRentalDataById(String documentId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      await db.collection('rent_property').doc(documentId).delete();
      log('Rental data deleted successfully');
    } catch (e) {
    log('Error deleting rental data: $e');
    }
  }



  Future<void> update(String id) async {


  final docRef = FirebaseFirestore.instance.collection('rent_property').doc(id);
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
  });

  notifyListeners();
}



}
