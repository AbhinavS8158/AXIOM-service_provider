import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  TextEditingController locationController = TextEditingController();
  bool isLoading = false;
  bool isManualEntry = false;

  // Toggle between manual entry and GPS location
  void toggleLocationMode() {
    isManualEntry = !isManualEntry;
    if (isManualEntry) {
      locationController.clear();
    }
    notifyListeners();
  }

  // Set manual location
  void setManualLocation(String address) {
    locationController.text = address;
    notifyListeners();
  }

  /// ✅ Fetch current location and set only **City, State**
  Future<void> fetchCurrentLocation() async {
    isLoading = true;
    notifyListeners();

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled. Please enable location services.');
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

      // ✅ Get user's GPS position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      // ✅ Convert coordinates → address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        // ✅ Fetch only city and state
        String city = place.locality ?? '';
        String state = place.administrativeArea ?? '';

        if (city.isEmpty && state.isEmpty) {
          throw Exception('Could not determine your city and state.');
        }

        // ✅ Set formatted city & state
        locationController.text = '$city, $state';

        log("📍 Detected location: $city, $state");
        isManualEntry = false; // Switch back to GPS mode
      } else {
        throw Exception('Unable to fetch location details.');
      }
    } catch (e) {
      log("❌ Error fetching location: $e");
      rethrow; // Let the UI handle showing a Snackbar
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void resetLocation() {
    locationController.clear();
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
