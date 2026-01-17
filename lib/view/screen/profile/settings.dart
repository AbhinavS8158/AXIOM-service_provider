import 'package:flutter/material.dart';
import 'package:service_provider/view/screen/aboutapp/about_app.dart';
import 'package:service_provider/view/screen/helpandsupport/help_support.dart';
import 'package:service_provider/view/screen/privacypolicy/privacy_policy.dart';

Widget buildSettings(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildSettingsTile(
          icon: Icons.lock_outline,
          title: 'Privacy & Security',
          subtitle: 'Password and security settings',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PrivacyPolicy(),
              ),
            );
          },
        ),

        _buildSettingsTile(
          icon: Icons.help_outline,
          title: 'Help & Support',
          subtitle: 'Get help and contact us',
         onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const HelpSupport(),
              ),
            );
          },
        ),

        _buildSettingsTile(
          icon: Icons.info_outline,
          title: 'About',
          subtitle: 'App version and information',
           onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AboutApp(),
              ),
            );
          },
        ),
      ],
    ),
  );
}

Widget _buildSettingsTile({
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
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
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Colors.grey.shade700,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade600,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey.shade400,
      ),
    ),
  );
}
