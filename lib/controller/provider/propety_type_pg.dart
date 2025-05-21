

import 'package:flutter/material.dart';

class DropdownPgProvider extends ChangeNotifier {
  String? _selectedPropertyType ="";
  int _bedroom = 0;
  int _bathroom =0;
  String? _furnished = "";
  String? _powerBackUp="";
  String? _parking ="";
  String? _status="";
String? _food='';

  String? get selectedPropertyType => _selectedPropertyType;
  int get bedroom=>_bedroom;
  int get bathroom => _bathroom;
  String? get furnished => _furnished;
   String? get  powerbackup => _powerBackUp;
    String? get parking => _parking;
    String? get status => _status;
    String? get food => _food;  

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
  void setFood(String food){
  _food=food;
    notifyListeners();
  }
}