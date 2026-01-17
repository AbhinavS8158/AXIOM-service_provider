import 'package:flutter/material.dart';
import 'package:service_provider/view/screen/helpandsupport/contact_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportContactSection extends StatelessWidget {
  const SupportContactSection({super.key});

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@serviceprovider.com',
      queryParameters: {
        'subject': 'Support Request',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      debugPrint('Could not open email app');
    }
  }

  Future<void> _launchPhone() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '+919876543210',
    );

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(
        phoneUri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      debugPrint('Could not launch dialer');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContactTile(
          icon: Icons.email_outlined,
          title: 'Email Support',
          subtitle: 'support@serviceprovider.com',
          onTap: _launchEmail,
          onSubtitleTap: _launchEmail,
        ),
        ContactTile(
          icon: Icons.phone_outlined,
          title: 'Call Support',
          subtitle: '+91 98765 43210',
          onTap: _launchPhone,
          onSubtitleTap: _launchPhone,
        ),
      ],
    );
  }
}
