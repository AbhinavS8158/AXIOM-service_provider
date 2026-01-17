import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_provider/model/transaction_model.dart';

class TransactionServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<TransactionModel>> getTransactions() {
    final uid = _auth.currentUser?.uid;

    if (uid == null) {
      return Stream.value([]);
    }
                    print(uid);

    return _firestore
        .collection('transactions')
        // Uncomment if you want only current user
         .where('ownerId', isEqualTo: uid)
        //  .where('propertyId' isEqualTo: )
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map(
                (doc) =>
                    TransactionModel.fromFirestore(doc.data(), doc.id),
              )
              .toList();
        });
  }
}
