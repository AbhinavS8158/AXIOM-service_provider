
  import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_provider/view/screen/booking_card/widgets/build_modern_info_row.dart';

Widget buildBookingDetailsCard(booking) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.calendar_month,
                  color: Colors.blue.shade700,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Booking Details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          buildModernInfoRow(
            Icons.access_time,
            "Duration",
            booking.duration,
            Colors.purple,
          ),
          const SizedBox(height: 14),
          buildModernInfoRow(
            Icons.calendar_today,
            "Move-in Date",
           DateFormat('dd/MMM/yyyy').format(booking.movein),
            Colors.teal,
          ),
        ],
      ),
    );
  }