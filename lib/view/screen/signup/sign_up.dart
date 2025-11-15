// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/auth/login_provider.dart';
import 'package:service_provider/controller/provider/auth/signup_provider.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/login/login_screen.dart';
import 'package:service_provider/view/screen/widget/label.dart';
import 'package:service_provider/view/screen/widget/textfield.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _showImageSourceDialog(BuildContext context) {
    final provider = context.read<SignUpProvider>();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Take Photo"),
            onTap: () {
              Navigator.pop(context);
              provider.pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("Choose from Gallery"),
            onTap: () {
              Navigator.pop(context);
              provider.pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SignUpProvider>();
    final loginController = context.read<LoginController>();

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
                  const SizedBox(height: 20),

                  Center(
                    child: GestureDetector(
                      onTap: () => _showImageSourceDialog(context),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: provider.pickedImage != null
                            ? FileImage(provider.pickedImage!)
                            : null,
                        child: provider.pickedImage == null
                            ? const Icon(Icons.add_a_photo,
                                size: 40, color: Colors.grey)
                            : null,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    "Create an account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColor.login),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Fill the details below to sign up",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),

                  const SizedBox(height: 30),

                  const Label(text: "Username"),
                  CustomTextField(
                    controller: provider.usernameController,
                    validator: provider.validateUsername,
                    hint: "John Doe",
                  ),
                  const SizedBox(height: 20),

                  const Label(text: "Email"),
                  CustomTextField(
                    controller: provider.emailController,
                    validator: provider.validateEmail,
                    hint: "example@gmail.com",
                  ),
                  const SizedBox(height: 20),

                  const Label(text: "Phone Number"),
                  CustomTextField(
                    controller: provider.phoneController,
                    validator: provider.validatePhone,
                    hint: "9876543210",
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),

                  const Label(text: "Password"),
                  CustomTextField(
                    controller: provider.passwordController,
                    validator: provider.validatePassword,
                    obscureText: provider.obscurePassword,
                    hint: "********",
                    toggleVisibility: provider.togglePasswordVisibility,
                  ),
                  const SizedBox(height: 20),

                  const Label(text: "Confirm Password"),
                  CustomTextField(
                    controller: provider.confirmPasswordController,
                    validator: provider.validateConfirmPassword,
                    obscureText: provider.obscureConfirmPassword,
                    hint: "********",
                    toggleVisibility:
                        provider.toggleConfirmPasswordVisibility,
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
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("CREATE ACCOUNT",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? ",
                          style: TextStyle(color: Colors.black54)),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen())),
                        child: const Text("Log in",
                            style: TextStyle(
                                color: AppColor.forgot,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
