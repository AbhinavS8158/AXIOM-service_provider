import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String id;
  final String propertyId;
  final String userId;
  final String bookingStatus;
  final String name;          
  final String user;          
  final String phone;
  final String email;
  final String totalAmount;
  final String message;
  final String duration;
  final DateTime movein;

  BookingModel({
    required this.id,
    required this.propertyId,
    required this.userId,
    required this.bookingStatus,
    required this.name,
    required this.user,
    required this.phone,
    required this.email,
    required this.totalAmount,
    required this.message,
    required this.duration,
    required this.movein,
  });

  factory BookingModel.fromFirestore(
    Map<String, dynamic> data,
    String documentId,
  ) {
    /// ✅ Handle Timestamp / String / null safely
    DateTime parsedMoveIn;

    final moveInRaw = data['moveInDate'];
    if (moveInRaw is Timestamp) {
      parsedMoveIn = moveInRaw.toDate();
    } else if (moveInRaw is String) {
      parsedMoveIn = DateTime.tryParse(moveInRaw) ?? DateTime.now();
    } else {
      parsedMoveIn = DateTime.now();
    }

    return BookingModel(
      id: documentId,
      propertyId: data['propertyId'] ?? '',
      userId: data['userId'] ?? '',
      bookingStatus: data['bookingStatus'] ?? '',
      name: data['propertyName'] ?? '',
      user: data['userName'] ?? '',
      phone: data['userPhone'] ?? '',
      email: data['userEmail'] ?? '',
      totalAmount: data['paidAmount']?.toString() ?? '',
      message: data['message'] ?? '',
      duration: data['duration'] ?? '',
      movein: parsedMoveIn,
    );
  }
}
