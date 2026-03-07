import 'package:flutter/material.dart';
import 'package:service_provider/model/booking_model.dart';
import 'package:service_provider/view/screen/booking_card/widgets/build_booking_details_card.dart';
import 'package:service_provider/view/screen/booking_card/widgets/build_customer_info_card.dart';
import 'package:service_provider/view/screen/booking_card/widgets/build_header.dart';
import 'package:service_provider/view/screen/booking_card/widgets/build_message_card.dart';
import 'package:service_provider/view/screen/booking_card/widgets/build_payment_card.dart';
import 'package:service_provider/view/screen/booking_card/widgets/build_service.dart';

class BookingDetails extends StatelessWidget {
  final BookingModel booking;

  const BookingDetails({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade50,
            Colors.purple.shade50,
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bookingCardBuildHeader(),
                const SizedBox(height: 24),

                buildServiceCard(booking),
                const SizedBox(height: 20),

                buildCustomerInfoCard(context,booking),
                const SizedBox(height: 20),

                buildBookingDetailsCard(booking),
                const SizedBox(height: 20),

                if (booking.message.isNotEmpty) ...[
                  buildMessageCard(booking),
                  const SizedBox(height: 20),
                ],

                buildPaymentCard(booking),
                const SizedBox(height: 20),

              
              ],
            ),
          ),
        ),
      ),
    );
  }

  

}