import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_provider/model/signup_model.dart';

class AuthDatabaseService {
  final CollectionReference _serviceProvider =
      FirebaseFirestore.instance.collection('service_provider');

  // Save user data
  Future<void> saveUser(SignUpModel user) async {
    await _serviceProvider.doc(user.uid).set(user.toMap());
  }

  // Get a user by UID
  Future<DocumentSnapshot> getUser(String uid) async {
    return await _serviceProvider.doc(uid).get();
  }

  final FirebaseAuth _auth =FirebaseAuth.instance;

  Future<UserCredential>register(String email,String password)async{
    return await _auth.createUserWithEmailAndPassword(
      email: email,
       password: password
       );
  }
}
