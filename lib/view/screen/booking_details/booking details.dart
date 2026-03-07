import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/booking_provider.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/booking_card/booking_card.dart';

class MyBookingsScreen extends StatelessWidget {
  final String propertyId;

  const MyBookingsScreen({
    super.key,
    required this.propertyId,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingProvider>().listenToBookings();
    });

    final provider = context.watch<BookingProvider>();

    final filteredBookings = provider.bookings
        .where((b) => b.propertyId == propertyId)
        .toList();

    return Scaffold(
      backgroundColor: AppColor.bg,
      body: filteredBookings.isEmpty
          ? const Center(child: Text("No booking found for this property"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredBookings.length,
              itemBuilder: (context, index) {
                final booking = filteredBookings[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: BookingDetails(booking: booking),
                );
              },
            ),
    );
  }
}
