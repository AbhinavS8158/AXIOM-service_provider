import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/auth/login_provider.dart';
import 'package:service_provider/view/screen/login/widget/login_form.dart';
import 'package:service_provider/view/screen/login/widget/login_header.dart';
import 'package:service_provider/view/screen/login/widget/social_login_section.dart';
import 'package:service_provider/view/screen/signup/sign_up.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                LoginHeader(),
                const SizedBox(height: 40),
                LoginForm(
                  emailController: controller.emailController,
                  passwordController: controller.passwordController,
                  obscurePassword: controller.obscurePassword,
                  isLoading: controller.isLoading,
                  onLogin: () => controller.loginUser(context),
                  onForgotPassword: () {
                    final email = controller.emailController.text.trim();
                    controller.sendPasswordResetEmail(email, context);
                  },
                  onNavigateToSignup: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SignUp()),
                    );
                  },
                ),
                const SizedBox(height: 40),
                SocialLoginSection(
  onGoogleLogin: (context) =>
      controller.googlelogin(context),
),


                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
