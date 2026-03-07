import 'package:flutter/material.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/helpandsupport/block/contact_help.dart';
import 'package:service_provider/view/screen/helpandsupport/block/header_card.dart';
import 'package:service_provider/view/screen/helpandsupport/block/help_support_appbar.dart';
import 'package:service_provider/view/screen/helpandsupport/faq_tile.dart';
import 'package:service_provider/view/screen/helpandsupport/section_tile.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: const HelpAppBar(title: 'Help & Support'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           HeaderCard(
            message: "Need help? Our support team help you.",
           ),

            const SizedBox(height: 24),

            SectionTitle(title: 'Frequently Asked Questions'),
            const SizedBox(height: 12),

            FaqTile(
              question: 'How do I edit my profile?',
              answer:
                  'Go to Profile > Edit Profile to update your personal information.',
            ),
            
            FaqTile(
              question: 'How do I contact support?',
              answer:
                  'You can contact us using the support options below.',
            ),

            const SizedBox(height: 24),

            SectionTitle(title: 'Contact Support'),
            const SizedBox(height: 12),

         SupportContactSection(),
          ],
        ),
      ),
    );
  }
}
