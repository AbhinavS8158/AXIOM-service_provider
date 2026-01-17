import 'package:flutter/material.dart';
import 'package:service_provider/view/screen/widget/bottom_navigation.dart';
import 'package:service_provider/view/screen/widget/socialmedial_button.dart';

class SocialLoginSection extends StatelessWidget {
  final Future<bool> Function(BuildContext context) onGoogleLogin;

  const SocialLoginSection({
    super.key,
    required this.onGoogleLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'OR',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),

        const SizedBox(height: 30),

        const Text(
          'Log in using',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54),
        ),

        const SizedBox(height: 30),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialMediaButton(
              iconPath: 'assets/img/google.png',
              onTap: () async {
                final isLogged =
                    await onGoogleLogin(context);

                if (isLogged && context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BottomNav(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(width: 24),
            const SocialMediaButton(
              iconPath: 'assets/img/facebook.png',
            ),
            const SizedBox(width: 24),
            const SocialMediaButton(
              iconPath: 'assets/img/apple.png',
            ),
          ],
        ),
      ],
    );
  }
}
