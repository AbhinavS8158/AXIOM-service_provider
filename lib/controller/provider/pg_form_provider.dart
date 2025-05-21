import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/model/pg_form_model.dart';

class PgFormProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phonenumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutcontroller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();

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
  String foodavailblity ='';
  String bedroom='';
  String bathroom ='';
  
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
  void setFood(String food){
    foodavailblity=food;
    notifyListeners();
  }
  void setBathroom(String value){
    bathroom=value;
    notifyListeners();
  }
  void setBedroom(String value){
    bedroom=value;
    notifyListeners();
  }
  void addtodb(BuildContext context) async {
  

    final PgData = PgFormModel(
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
      food: foodavailblity,
      bedroom: bedroom,
      bathroom: bathroom,
    
      amenities: selectedAmenities,
    );

    final jsonData = PgData.toJson();

    FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      await db.collection('pg_property').add(jsonData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("pg property added successfully")),
      );
    } catch (e) {
      print('Error adding pg data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to add pg property")),
      );
    }
  }
}