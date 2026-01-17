import 'package:flutter/material.dart';
import 'package:service_provider/controller/db/booking_services.dart';
import 'package:service_provider/model/booking_model.dart';

class BookingProvider extends ChangeNotifier {
  final BookingServices _bookingServices = BookingServices();

  BookingModel? _currentBooking;
  BookingModel? get currentBooking => _currentBooking;

  List<BookingModel> _bookings = [];
  List<BookingModel> get bookings => _bookings;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Fetch booking by propertyId (already working)
  Future<void> fetchBookingByPropertyId(String propertyId) async {
    try {
      _setLoading(true);
      _currentBooking =
          await _bookingServices.fetchBookingByPropertyId(propertyId);
    } catch (e) {
      debugPrint('Booking fetch error: $e');
      _currentBooking = null;
    } finally {
      _setLoading(false);
    }
  }

  /// Listen to all bookings
  void listenToBookings() {
    _bookingServices.getBookings().listen((data) {
      _bookings = data;
      notifyListeners();
    });
  }

  void clearBooking() {
    _currentBooking = null;
    notifyListeners();
  }
}
