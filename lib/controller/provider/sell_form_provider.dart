import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/model/sell_form_model.dart';

class SellFormProvider extends ChangeNotifier {
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
  String construction_status='';
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
  void setStatus(String status){
    construction_status=status;
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

  void addtodb(BuildContext context) async {
    print('Sell Data:');
    print('Name: $name');
    print('Property Type: $propertyType');
    print('Photo Paths: $photoPath');
    print('Location: $location');
    print('Phone: $phoneNumber');
    print('Email: $email');
    print('About: $about');
    print('Amount: $amount');
    print('Furnished: $furnished');
    print('Powerbackup: $powerbackup');
    print('construction status:$construction_status');
    print('Amenities: $selectedAmenities');

    final sellData = SellFormModel(
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
      constructionstatus:construction_status,
      amenities: selectedAmenities,
    );

    final jsonData = sellData.toJson();

    FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      await db.collection('sell_property').add(jsonData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selling property added successfully")),
      );
    } catch (e) {
      print('Error adding selling data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to add sell property")),
      );
    }
  }
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