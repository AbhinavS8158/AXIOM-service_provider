
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildCustomerInfoCard(BuildContext context,booking) {
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
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.person,
                color: Colors.purple.shade700,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "Customer Information",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Name
        _buildModernInfoRow(
          Icons.person_outline,
          "Name",
          booking.user,
          Colors.blue,
        ),

        const SizedBox(height: 14),

        // Phone (tap + copy)
        GestureDetector(
          onTap: () => _launchPhone(booking.phone),
          onLongPress: () =>
              _copyToClipboard(context, booking.phone, "Phone number"),
          child: _buildModernInfoRow(
            Icons.phone_outlined,
            "Phone",
            booking.phone,
            Colors.green,
          ),
        ),

        const SizedBox(height: 14),

        // Email (tap + copy)
        GestureDetector(
          onTap: () => _launchEmail(booking.email),
          onLongPress: () =>
              _copyToClipboard(context, booking.email, "Email"),
          child: _buildModernInfoRow(
            Icons.email_outlined,
            "Email",
            booking.email,
            Colors.orange,
          ),
        ),
      ],
    ),
  );
}

Future<void> _launchPhone(String phone) async {
  final uri = Uri(scheme: 'tel', path: phone);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}

Future<void> _launchEmail(String email) async {
  final uri = Uri(scheme: 'mailto', path: email);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}

void _copyToClipboard(BuildContext context, String value, String label) {
  Clipboard.setData(ClipboardData(text: value));
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$label copied to clipboard'),
      duration: const Duration(seconds: 2),
    ),
  );
}
 Widget _buildModernInfoRow(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 18,
            color: color,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }