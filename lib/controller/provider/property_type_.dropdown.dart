import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:service_provider/model/propertycard_form_model.dart';

class PropertyTypeProvider extends ChangeNotifier {
  String? _selectedPropertyType = "";
  int _bedroom = 0;
  int _bathroom = 0;
  String? _furnished;
  String? _powerBackUp = "";
  String? _parking = "";

  // 👇 Track which property id was initialized
  String? _initializedPropertyId;

  String? get selectedPropertyType => _selectedPropertyType;
  int get bedroom => _bedroom;
  int get bathroom => _bathroom;
  String? get furnished => _furnished;
  String? get powerbackup => _powerBackUp;
  String? get parking => _parking;

  void setPropertyType(String value) {
    _selectedPropertyType = value;
    notifyListeners();
  }

  void setBedroom(int value) {
    _bedroom = value;
    notifyListeners();
  }

  void setBathroom(int value) {
    _bathroom = value;
    notifyListeners();
  }

  void increementbedroom() {
    _bedroom++;
    log("Bedroom incremented to $_bedroom");
    notifyListeners();
  }

  void decrementBedrooms() {
    if (_bedroom > 0) {
      _bedroom--;
      log("Bedroom decremented to $_bedroom");
      notifyListeners();
    }
  }

  void increementbathroom() {
    _bathroom++;
    notifyListeners();
  }

  void decreementbathroom() {
    if (_bathroom > 0) {
      _bathroom--;
      notifyListeners();
    }
  }

  void setFurnished(String value) {
    _furnished = value;
    notifyListeners();
  }

  void setPowerBackup(String value) {
    _powerBackUp = value;
    notifyListeners();
  }

  void setParking(String value) {
    _parking = value;
    notifyListeners();
  }

  /// Initialize property data only once per property id
  void initializeFromProperty(PropertycardFormModel property) {
    if (_initializedPropertyId == property.id) return;

    _initializedPropertyId = property.id;

    _bedroom = int.tryParse(property.bedroom) ?? 0;
    _bathroom = int.tryParse(property.bathroom) ?? 0;
    _selectedPropertyType = property.propertyType;
    _furnished = property.furnished;
    _powerBackUp = property.powerbackup;

    log("Initialized for property ${property.id}: "
        "bedroom=$_bedroom, bathroom=$_bathroom");

    notifyListeners();
  }

  void clearSelections() {
    _initializedPropertyId = null; // FIXED HERE
    _selectedPropertyType = null;
    _furnished = null;
    _powerBackUp = null;
    _parking = null;
    _bedroom = 0;
    _bathroom = 0;
    notifyListeners();
  }
}
