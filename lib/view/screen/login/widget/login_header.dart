import 'package:flutter/material.dart';
import 'package:service_provider/utils/app_color.dart';

class LoginHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const LoginHeader({
    super.key,
    this.title = 'Login here',
    this.subtitle = "Welcome back you've been missed!",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Login here',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColor.login,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Welcome back you've been missed!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: AppColor.blk,
          ),
        ),
      ],
    );
  }
}
