import 'package:flutter/material.dart';
import 'package:service_provider/utils/app_color.dart';

class AppInfoHeader extends StatelessWidget {
  final String appName;
  final String version;
  final IconData icon;

  const AppInfoHeader({
    super.key,
    this.appName = 'Service Provider App',
    this.version = 'Version 1.0.0',
    this.icon = Icons.miscellaneous_services,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: AppColor.forgot.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              size: 40,
              color: AppColor.forgot,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            appName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            version,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
