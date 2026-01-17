import 'package:flutter/material.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/aboutapp/block/about_appbar.dart';
import 'package:service_provider/view/screen/aboutapp/block/app_logo.dart';
import 'package:service_provider/view/screen/aboutapp/block/contact_section.dart';
import 'package:service_provider/view/screen/aboutapp/section_bullet_point.dart';
import 'package:service_provider/view/screen/privacypolicy/section_text.dart';
import 'package:service_provider/view/screen/privacypolicy/section_title.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
     appBar: const AboutAppAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Logo
            AppInfoHeader(
              appName: 'Service Provider App',
              version: 'Version 1.2.0',
              icon: Icons.build_circle_outlined,
            ),

            const SizedBox(height: 32),

            sectionTitle('About'),
            sectionText(
              'Service Provider App is designed to help service providers manage their profiles, bookings, and customer interactions efficiently and securely.',
            ),

            const SizedBox(height: 20),

            sectionTitle('Features'),
            bulletPoint('Manage profile and personal details'),
            bulletPoint('Secure authentication and data protection'),
            bulletPoint('Easy access to bookings and services'),
            bulletPoint('User-friendly interface'),

            const SizedBox(height: 20),

            sectionTitle('Technologies Used'),
            bulletPoint('Flutter'),
            bulletPoint('Firebase Authentication'),
            bulletPoint('Cloud Firestore'),

            const SizedBox(height: 20),

          ContactSection(),


            const SizedBox(height: 32),

            Center(
              child: Text(
                '© 2025 Axiom Service Provider. All rights reserved.',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
