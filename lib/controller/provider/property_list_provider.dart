import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class PropertyListProvider extends ChangeNotifier {
  PropertycardFormModel ? _property;
  int _currentCarouselIndex = 0;

  PropertycardFormModel get property {
    if (_property == null) {
      loadProperty();
    }
    return _property!;
  }

  int get currentCarouselIndex => _currentCarouselIndex;

  void setCurrentCarouselIndex(int index) {
    _currentCarouselIndex = index;
    notifyListeners();
  }

  Future<void> loadProperty() async {
    try {
      // Replace with your document ID or fetch logic
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('properties')
          .doc('property_id') // Replace with actual doc ID
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        _property = PropertycardFormModel(
         
          name: data['name'] ?? '',
          propertyType: data['propertyType'] ?? '',
          photoPath: List<String>.from(data['images'] ?? []),
          location: data['location'] ?? '',
          phoneNumber: data['phone'] ?? '',
          email: data['email'] ?? '',
          about: data['about'] ?? '',
          amount: data['price'] ?? 0,
          bedroom: data['bedrooms'] ?? 0,
          bathroom: data['bathrooms'] ?? 0,
          furnished: data['furnishedType'] ?? '',
          powerbackup: data['backup'] ?? '',
          amenities: (data['amenities'] as List<dynamic>? ?? [])
              .map((item) => {'name': item.toString()})
              .toList(),
        ); 
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to load property: $e');
    }
  }

  void deleteProperty(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Property deleted successfully')),
    );
  }

  void updateProperty(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to edit property page')),
    );
  }
}
