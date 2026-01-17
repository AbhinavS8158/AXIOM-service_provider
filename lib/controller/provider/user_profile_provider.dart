import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_provider/model/signup_model.dart';

class ProfileProvider {
  Stream<SignUpModel?> get userStream {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return Stream.value(null);
    }

    return FirebaseFirestore.instance
        .collection('service_provider')
        .doc(uid)
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;
      return SignUpModel.fromMap(doc.data()!, doc.id);
    });
  }
}
