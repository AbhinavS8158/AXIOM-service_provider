import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_provider/model/signup_model.dart';

class AuthDatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Save user
  Future<void> saveUser(SignUpModel user) async {
    await _firestore
        .collection('service_provider')
        .doc(user.uid)
        .set(user.toMap());
  }

  /// Fetch current logged-in user
  Future<SignUpModel?> getUser() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    try {
      final doc =
          await _firestore.collection('service_provider').doc(uid).get();

      if (!doc.exists) return null;

      return SignUpModel.fromMap(
        doc.data() as Map<String, dynamic>,
        doc.id,
      );
    } catch (e) {
      print("Error fetching user: $e");
      return null;
    }
  }

  /// Update user profile
 Future<void> updateUser({
  required String uid,
  required String username,
  required String phone,
  required String email,
  String? profileImage,
}) async {
  await _firestore
      .collection("service_provider")
      .doc(uid)
      .update({
    "username": username,
    "phone": phone,
    "email": email,
    if (profileImage != null) "profileImage": profileImage,
  });
}

}
