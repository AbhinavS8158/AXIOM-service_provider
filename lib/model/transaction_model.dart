import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String propertyId;
  final String propertyName;
  final String userId;
  final String amount;
  final String paymentMethod;
  final String status; // success | failed | pending
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.propertyId,
    required this.propertyName,
    required this.userId,
    required this.amount,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
  });

  // ---------- DERIVED STATE ----------
  bool get isSuccess => status == 'success';

  // ---------- FROM FIRESTORE ----------
  factory TransactionModel.fromFirestore(
    Map<String, dynamic> data,
    String documentId,
  ) {
    /// ✅ Handle Timestamp / String / null safely
    DateTime parsedCreatedAt;

    final createdAtRaw = data['createdAt'];
    if (createdAtRaw is Timestamp) {
      parsedCreatedAt = createdAtRaw.toDate();
    } else if (createdAtRaw is String) {
      parsedCreatedAt =
          DateTime.tryParse(createdAtRaw) ?? DateTime.now();
    } else {
      parsedCreatedAt = DateTime.now();
    }

    return TransactionModel(
      id: documentId,
      propertyId: data['propertyId'] ?? '',
      propertyName: data['propertyName'] ?? '',
      userId: data['userId'] ?? '',
      amount: data['amount']?.toString() ?? '',
      paymentMethod: data['paymentMethod'] ?? '',
      status: data['status'] ?? 'pending',
      createdAt: parsedCreatedAt,
    );
  }

  // ---------- TO FIRESTORE ----------
  Map<String, dynamic> toJson() {
    return {
      'propertyId': propertyId,
      'propertyName': propertyName,
      'userId': userId,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
