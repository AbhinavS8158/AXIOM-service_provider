import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/model/propertycard_form_model.dart';

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

// Stream<PropertycardFormModel?> getPropertyStream(String id) {
//   return FirebaseFirestore.instance
//       .collection('properties')
//       .doc(id)
//       .snapshots()
//       .map((doc) =>
//           doc.exists ? PropertycardFormModel.fromJson(doc.data()!) : null);
// }
final _collection = FirebaseFirestore.instance.collection('rent_property');

  Stream<PropertycardFormModel?> getPropertyStream(String id) {
    return _collection.doc(id).snapshots().map((doc) {
      if (!doc.exists) return null;

      final data = doc.data()!;
      // ✅ make sure id is included
      return PropertycardFormModel.fromJson({
        ...data,
        'id': doc.id,
      });
    });
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
      // ❌ don't pass bookingstatus here → default from toJson()
      // bookingstatus: 'not booked',
    );

    final data = property.toJson()
      ..['uid'] = uid
      ..['timestamp'] = FieldValue.serverTimestamp();

    await FirebaseFirestore.instance.collection(collectionName).add(data);
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
/// Clear controllers and reset provider state to defaults.
/// Does NOT delete the Firestore document; only clears UI/edit state.
void clearAllFields() {
  // Clear text controllers
  nameController.clear();
  locationController.clear();
  phonenumController.clear();
  emailController.clear();
  aboutcontroller.clear();
  amountcontroller.clear();

  // Reset simple fields
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

  // Reset flags
  isInitialized = false;
  documentId = null;
  isLoading = false;

  notifyListeners();
}




}
