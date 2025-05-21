// lib/service/rent_property_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class PgPropertyServices {
  final _pgCollection = FirebaseFirestore.instance.collection('pg_property');

  Stream<List<PropertycardFormModel>> getPgProperties() {
    return _pgCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() ;
        return PropertycardFormModel(
      
          name: data['name'] ?? '',
          propertyType: data['propertyType'] ?? '',
          photoPath: List<String>.from(data['photoPath'] ?? []),
          location: data['location'] ?? '',
          phoneNumber: data['phoneNumber'] ?? '',
          email: data['email'] ?? '',
          about: data['about'] ?? '',
          amount: data['amount'] ?? '',
          furnished: data['furnished'] ?? '',
          powerbackup: data['powerbackup'] ?? '',
          amenities: List<Map<String, dynamic>>.from(data['amenities'] ?? []),
          bathroom: data['bathroom'] ?? '',
          bedroom: data['bedroom'] ?? '',
        );
      }).toList();
    });
  }
}
