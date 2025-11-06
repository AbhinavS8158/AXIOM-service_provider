

import 'dart:developer';

import 'package:flutter/material.dart';

class PropertyTypeProvider extends ChangeNotifier {
  String? _selectedPropertyType ="";
  int _bedroom = 0;
  int _bathroom =0;
  String? _furnished ;
  String? _powerBackUp="";
  String? _parking ="";

  String? get selectedPropertyType => _selectedPropertyType;
  int get bedroom=>_bedroom;
  int get bathroom => _bathroom;
  String? get furnished => _furnished;
   String? get  powerbackup => _powerBackUp;
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

  void increementbedroom(){
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

   void increementbathroom(){
    _bathroom++;
    notifyListeners();
  }
  void decreementbathroom(){
  if(_bathroom > 0){
      _bathroom--;
    notifyListeners();
  }
  }
  void setFurnished(String value){
    _furnished=value;
    notifyListeners();
  }
  void setPowerBackup(String value){
    _powerBackUp =value;
    notifyListeners();

  }
  void setParking(String value){
    _parking=value;
    notifyListeners();
  }
  
  void clearSelections() {
  _selectedPropertyType = null;
  _furnished = null;
  _powerBackUp = null;
  _bedroom = 0;
  _bathroom = 0;
  notifyListeners();
}

}