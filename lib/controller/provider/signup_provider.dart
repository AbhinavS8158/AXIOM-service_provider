// providers/signup_provider.dart



import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/model/signup_model.dart';
import 'package:service_provider/view/screen/login/login_screen.dart';


class SignUpProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

 void submitForm(BuildContext context) async {
  if (!formKey.currentState!.validate()) return;

 
  final signUpData = SignUpModel(
    username: usernameController.text.trim(),
    email: emailController.text.trim(),
    password: passwordController.text,
    confirmPassword: confirmPasswordController.text,
  );

  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email:signUpData. email,
      password: signUpData.password,
    );

    log("✅ Sign Up Success");
    log("Username: ${usernameController.text}");
    log("Email: ${signUpData.email}");
 // ignore: use_build_context_synchronously
 ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Row(
      children: [
        Icon(Icons.check_circle, color: Colors.greenAccent, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            "Sign up successful",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    ),
    behavior: SnackBarBehavior.floating,
    // backgroundColor: const Color.fromARGB(255, 126, 239, 148).withOpacity(0.9),
    backgroundColor: Colors.grey[100],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 6,
    duration: const Duration(seconds: 3),

  ),
);


     // ignore: use_build_context_synchronously
     Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));

    // Optionally clear the form
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  } on FirebaseAuthException catch (e) {
    log("❌ Firebase Auth Error: ${e.message}");

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.message ?? "An error occurred")),
    );
  }
}


  void disposeControllers() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
