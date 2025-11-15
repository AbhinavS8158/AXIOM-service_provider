import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_provider/model/properycard_form_model.dart';
class PgPropertyServices {
  final _pgCollection = FirebaseFirestore.instance.collection('pg_property');
  Stream<List<PropertycardFormModel>> getPgProperties() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      // Return empty list if no user is logged in
      return Stream.value([]);
    }
    return _pgCollection.where('uid', isEqualTo: uid).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
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
            status: data['status'] ?? '0',
          id: doc.id, 
          food: data['food']??'',

        );
      }).toList();
    });
  }
}
