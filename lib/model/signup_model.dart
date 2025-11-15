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
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
