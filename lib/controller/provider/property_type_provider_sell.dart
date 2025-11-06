

import 'package:flutter/material.dart';

class PropertyTypeProviderSell extends ChangeNotifier {
  String? _selectedPropertyType ="";
  int _bedroom = 0;
  int _bathroom =0;
  String? _furnished = "";
  String? _powerBackUp="";
  String? _parking ="";
  String? _status="";

  String? get selectedPropertyType => _selectedPropertyType;
  int get bedroom=>_bedroom;
  int get bathroom => _bathroom;
  String? get furnished => _furnished;
   String? get  powerbackup => _powerBackUp;
    String? get parking => _parking;
    String? get status => _status;
  

  void setPropertyType(String value) {
    _selectedPropertyType = value;
    notifyListeners();
  }
  void increementbedroom(){
    _bedroom++;
    notifyListeners();
  }
 void decrementBedrooms() {
    if (_bedroom > 0) {
      _bedroom--;
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
  void setStatus(String value){
    _status=value;
    notifyListeners();
  }
  void resetSelections() {
    _selectedPropertyType = null;
    _furnished = null;
    _powerBackUp = null;
    _status = null;
    _bedroom = 0;
    _bathroom = 0;
    notifyListeners();
  }
}