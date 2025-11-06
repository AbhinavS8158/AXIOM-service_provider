import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class PgPropertyServices {
  final _pgCollection = FirebaseFirestore.instance.collection('pg_property');

  Future<void> addPgProperty(PropertycardFormModel property) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        throw Exception("User not logged in");
      }

      // Validate required fields
      if (property.name.isEmpty ||
          property.propertyType.isEmpty ||
          property.location.isEmpty ||
          property.phoneNumber.isEmpty ||
          property.email.isEmpty ||
          property.amount.isEmpty ||
          property.bathroom.isEmpty ||
          property.bedroom.isEmpty) {
        throw Exception("All required fields, including bedroom and bathroom, must be filled");
      }

      final jsonData = property.toJson()
        ..['uid'] = uid
        ..['timestamp'] = FieldValue.serverTimestamp();

      await _pgCollection.add(jsonData);
    } catch (e) {
      debugPrint('Error adding PG property to Firestore: $e');
      rethrow;
    }
  }

  Future<void> updatePgProperty(String docId, PropertycardFormModel property) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        throw Exception("User not logged in");
      }

      final jsonData = property.toJson()
        ..['uid'] = uid
        ..['timestamp'] = FieldValue.serverTimestamp();

      await _pgCollection.doc(docId).update(jsonData);
    } catch (e) {
      debugPrint('Error updating PG property in Firestore: $e');
      rethrow;
    }
  }

  Stream<List<PropertycardFormModel>> getPgProperties() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return Stream.value([]);
    }

    return _pgCollection.where('uid', isEqualTo: uid).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return PropertycardFormModel(
          id: doc.id,
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
          food: data['food'],
          status: data['status'],
        );
      }).toList();
    });
  }
}