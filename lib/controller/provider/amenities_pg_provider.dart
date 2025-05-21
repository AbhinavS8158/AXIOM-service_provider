
// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/model/amenity_model.dart';



class AmenitiesPgProvider extends ChangeNotifier {
  final List<Amenity> _amenities = [
    Amenity(name: "Gym", icon: Icons.fitness_center),
    Amenity(name: "Gas", icon: Icons.local_gas_station),
    Amenity(name: "Pool", icon: Icons.pool),
    Amenity(name: "Lift", icon: Icons.elevator),
    Amenity(name: "Gate", icon: Icons.door_sliding_outlined),
    Amenity(name: "Car Parking", icon: Icons.directions_car),
    Amenity(name: "Pets Allowed", icon: Icons.pets),
    Amenity(name: "Fridge", icon: Icons.kitchen),
    Amenity(name: "Washing Machine", icon: Icons.local_laundry_service),
  ];

  List<Amenity> get amenities => _amenities;

  void toggleSelection(int index) {
    _amenities[index].isSelected = !_amenities[index].isSelected;
    notifyListeners();
  }

  List<Map<String, dynamic>> getSelectedAmenities() {
    return _amenities
        .where((amenity) => amenity.isSelected)
        .map((a) => {
              'name': a.name,
              'icon': a.icon.codePoint,
              'fontFamily': a.icon.fontFamily,
            })
        .toList();
  }
}
