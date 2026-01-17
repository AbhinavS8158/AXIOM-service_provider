import 'package:flutter/material.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/privacypolicy/block/privacy_policy_appbar.dart';
import 'package:service_provider/view/screen/privacypolicy/section_text.dart';
import 'package:service_provider/view/screen/privacypolicy/section_title.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
     appBar: PrivacyPolicyAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle('Introduction'),
            sectionText(
              'Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you use our application.',
            ),

            const SizedBox(height: 16),

            sectionTitle('Information We Collect'),
            sectionText(
              'We may collect personal information such as your name, email address, phone number, and profile image when you register or update your profile.',
            ),

            const SizedBox(height: 16),

            sectionTitle('How We Use Your Information'),
            sectionText(
              'Your information is used to provide and improve our services, communicate with you, and ensure the security of your account.',
            ),

            const SizedBox(height: 16),

            sectionTitle('Data Security'),
            sectionText(
              'We implement appropriate security measures to protect your personal data from unauthorized access, alteration, or disclosure.',
            ),

            const SizedBox(height: 16),

            sectionTitle('Third-Party Services'),
            sectionText(
              'We may use third-party services such as Firebase to store and manage data securely. These services follow their own privacy policies.',
            ),

            const SizedBox(height: 16),

            sectionTitle('Changes to This Policy'),
            sectionText(
              'We may update this Privacy Policy from time to time. Any changes will be reflected on this page.',
            ),

            const SizedBox(height: 24),

            Center(
              child: Text(
                'Last updated: January 2025',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
