import 'package:flutter/material.dart';
import 'package:service_provider/utils/app_color.dart';

class HeaderCard extends StatelessWidget {
  final String message;
  final IconData icon;

  const HeaderCard({
    super.key,
    this.message = 'Need help? We’re here to support you.',
    this.icon = Icons.support_agent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.forgot.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColor.forgot,
            size: 32,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
