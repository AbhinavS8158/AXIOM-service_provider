import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_provider/model/booking_model.dart';

class BookingServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Fetch single booking by propertyId
  Future<BookingModel?> fetchBookingByPropertyId(String propertyId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    final querySnapshot = await _firestore
        .collection('bookings')
        .where('userId', isEqualTo: uid)
        .where('propertyId', isEqualTo: propertyId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return null;
    }

    final doc = querySnapshot.docs.first;
    return BookingModel.fromFirestore(doc.data(), doc.id);
  }

  /// Stream for all user bookings (optional – keep if needed)
  Stream<List<BookingModel>> getBookings() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection('bookings')
        // .where('userId', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) =>
                  BookingModel.fromFirestore(doc.data(), doc.id))
              .toList();
        });
  }
}
