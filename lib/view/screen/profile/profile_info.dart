import 'package:flutter/material.dart';
import 'package:service_provider/model/signup_model.dart';

Widget buildProfileInfo(SignUpModel user) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Profile Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildInfoCard(
          icon: Icons.person_outline,
          title: 'Full Name',
          value: user.username,
        ),
        const SizedBox(height: 8),
        _buildInfoCard(
          icon: Icons.email_outlined,
          title: 'Email',
          value: user.email,
        ),
        const SizedBox(height: 8),
        _buildInfoCard(
          icon: Icons.phone_outlined,
          title: 'Phone Number',
          value: user.phone,
        ),
      ],
    ),
  );
}
Widget _buildInfoCard({
  required IconData icon,
  required String title,
  required String value,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Colors.black87,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade600,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      
    ),
  );
}
