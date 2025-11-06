
// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/model/amenity_model.dart';



class AmenitiesSellProvider extends ChangeNotifier {
  final List<Amenity> _amenities = [
    Amenity(name: "Gym", icon: Icons.fitness_center),
    Amenity(name: "Gas", icon: Icons.local_gas_station),
    Amenity(name: "Pool", icon: Icons.pool),
    Amenity(name: "Lift", icon: Icons.elevator),
    Amenity(name: "Gate", icon: Icons.door_sliding_outlined),
    Amenity(name: "Car Parking", icon: Icons.directions_car),
    Amenity(name: "Childrens Playarea", icon: Icons.sports_soccer),
    Amenity(name: "24x7 Water", icon: Icons.water_drop_outlined),
    Amenity(name: "24x7 Security", icon: Icons.security_sharp),
  ];

  bool isSyncedFromProperty = false;

  List<Amenity> get amenities => _amenities;

  void setSelectedFromProperty(List<String> selectedNames) {
    for (var amenity in _amenities) {
      amenity.isSelected = selectedNames.contains(amenity.name);
    }
    isSyncedFromProperty = true;
    notifyListeners();
  }

  void resetSyncFlag() {
    isSyncedFromProperty = false;
    notifyListeners();
  }

  void toggleSelection(int index) {
    _amenities[index].isSelected = !_amenities[index].isSelected;
    notifyListeners();
  }

  List<String> getSelectedAmenities() {
    return _amenities
        .where((amenity) => amenity.isSelected)
        .map((a) => a.name)
        .toList();
  }

  void clearSelectedAmenities() {
    for (var amenity in _amenities) {
      amenity.isSelected = false;
    }
    notifyListeners();
  }

  
}