import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  TextEditingController locationController = TextEditingController();
  bool isLoading = false;
  bool isManualEntry = false;

  double? latitude;
  double? longitude;

  void toggleLocationMode() {
    isManualEntry = !isManualEntry;
    if (isManualEntry) {
      locationController.clear();
    }
    notifyListeners();
  }

  void setManualLocation(String address) {
    locationController.text = address;
    notifyListeners();
  }

  
  Future<void> fetchCurrentLocation() async {
    isLoading = true;
    notifyListeners();

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled. Please enable them.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied. Please allow access.');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Location permission permanently denied. Please enable it from app settings.',
        );
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      latitude = position.latitude;
      longitude = position.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        String street = place.street ?? ''; 
        String subLocality = place.subLocality ?? ''; 
        String locality = place.locality ?? '';
        String district = place.subAdministrativeArea ?? ''; 
        String state = place.administrativeArea ?? ''; 

        
        String address = [
          street,
          if (subLocality.isNotEmpty) subLocality,
          if (locality.isNotEmpty) locality,
          if (district.isNotEmpty) district,
          if (state.isNotEmpty) state,
        ].where((part) => part.trim().isNotEmpty).join(', ');

        if (address.isEmpty) {
          throw Exception('Unable to determine your exact address.');
        }

        
        locationController.text = address;
        log("📍 Exact address: $address");
        log("🌐 Coordinates: $latitude, $longitude");

        isManualEntry = false;
      } else {
        throw Exception('Unable to fetch location details.');
      }
    } catch (e) {
      log("❌ Error fetching location: $e");
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  void resetLocation() {
    locationController.clear();
    latitude = null;
    longitude = null;
    isLoading = false;
    isManualEntry = false;
    notifyListeners();
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }
}
