// view/screen/signup/signup_screen.dart

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/auth/login_provider.dart';
import 'package:service_provider/controller/provider/auth/signup_provider.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/home%20Screen/home_screen.dart';
import 'package:service_provider/view/screen/login/login_screen.dart';
import 'package:service_provider/view/screen/widget/label.dart';
import 'package:service_provider/view/screen/widget/socialmedial_button.dart';
import 'package:service_provider/view/screen/widget/textfield.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);
    final controller = Provider.of<LoginController>(context);
    final formKey = GlobalKey<FormState>(); // 🔑 Moved here

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "Create an account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColor.login,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Create an account so you can explore all the\nHotels",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: AppColor.blk),
                  ),
                  const SizedBox(height: 40),

                  const Label(text: "Username"),
                  CustomTextField(
                    controller: provider.usernameController,
                    validator: provider.validateUsername,
                    hint: "John",
                  ),
                  const SizedBox(height: 20),

                  const Label(text: "Email"),
                  CustomTextField(
                    controller: provider.emailController,
                    validator: provider.validateEmail,
                    hint: "abc@gmail.com",
                  ),
                  const SizedBox(height: 20),

                  const Label(text: "Password"),
                  CustomTextField(
                    obscureText: provider.obscurePassword,
                    controller: provider.passwordController,
                    validator: provider.validatePassword,
                    hint: '********',
                    toggleVisibility: provider.togglePasswordVisibility,
                  ),
                  const SizedBox(height: 20),

                  const Label(text: "Confirm Password"),
                  CustomTextField(
                    obscureText: provider.obscureConfirmPassword,
                    controller: provider.confirmPasswordController,
                    validator: provider.validateConfirmPassword,
                    hint: '********',
                    toggleVisibility: provider.toggleConfirmPasswordVisibility,
                  ),
                  const SizedBox(height: 40),

                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        provider.submitForm(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.loginbt,
                      foregroundColor: AppColor.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'CREATE ACCOUNT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.black54),
                      ),
                      GestureDetector(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            ),
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            color: AppColor.forgot,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

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
                          bool isLogged = await controller.googlelogin();
                          if (isLogged) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomeScreen(),
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
                      const SocialMediaButton(iconPath: 'assets/img/apple.png'),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
