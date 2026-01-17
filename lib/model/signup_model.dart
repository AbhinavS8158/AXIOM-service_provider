import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpModel {
  final String uid;
  final String username;
  final String email;
  final String phone;
  final String? profileImage;
  final DateTime createdAt;

  SignUpModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.phone,
    required this.createdAt,
    this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "username": username,
      "email": email,
      "phone": phone,
      "profileImage": profileImage,
      "createdAt": Timestamp.fromDate(createdAt),
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> data, String id) {
    return SignUpModel(
      uid: data['uid'] ?? id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      profileImage: data['profileImage'],
      createdAt: data['createdAt'] is Timestamp
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}
