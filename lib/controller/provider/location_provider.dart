import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  TextEditingController locationController = TextEditingController();
  bool isLoading = false;
  bool isManualEntry = false;

  // ✅ Optional: Store latitude & longitude for later use (e.g., Firestore)
  double? latitude;
  double? longitude;

  /// ✅ Toggle between manual entry and GPS location
  void toggleLocationMode() {
    isManualEntry = !isManualEntry;
    if (isManualEntry) {
      locationController.clear();
    }
    notifyListeners();
  }

  /// ✅ Set manual location from text input
  void setManualLocation(String address) {
    locationController.text = address;
    notifyListeners();
  }

  /// ✅ Fetch current location and create accurate address like:
  /// "Chakkarmoola, Niramaruthur, Tirur, Kerala"
  Future<void> fetchCurrentLocation() async {
    isLoading = true;
    notifyListeners();

    try {
      // Step 1: Check if location service is enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled. Please enable them.');
      }

      // Step 2: Handle permissions
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

      // Step 3: Get current GPS position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      latitude = position.latitude;
      longitude = position.longitude;

      // Step 4: Reverse geocode (coordinates → address)
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        // ✅ Extract important fields safely
        String street = place.street ?? ''; // e.g. "Chakkarmoola"
        String subLocality = place.subLocality ?? ''; // e.g. "Niramaruthur"
        String locality = place.locality ?? ''; // e.g. "Tirur"
        String district = place.subAdministrativeArea ?? ''; // e.g. "Malappuram"
        String state = place.administrativeArea ?? ''; // e.g. "Kerala"

        // ✅ Build full address
        // If street or sublocality missing, skip gracefully
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

        // ✅ Update the text field
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

  /// ✅ Reset location input
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
