import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/auth/signup_provider.dart';
import 'package:service_provider/utils/app_color.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  // ---------- IMAGE PICKER ----------
  // void _showImagePicker(BuildContext context) {
  //   final provider = Provider.of<SignUpProvider>(context, listen: false);

  //   showModalBottomSheet(
  //     context: context,
  //     builder:
  //         (_) => Wrap(
  //           children: [
  //             ListTile(
  //               leading: const Icon(Icons.camera_alt),
  //               title: const Text("Take Photo"),
  //               onTap: () async {
  //                 Navigator.pop(context);
  //                 await provider.pickImage(ImageSource.camera);
  //                 await provider.updateProfileImage(context);
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.photo),
  //               title: const Text("Choose from Gallery"),
  //               onTap: () async {
  //                 Navigator.pop(context);
  //                 await provider.pickImage(ImageSource.gallery);
  //                 await provider.updateProfileImage(context);
  //               },
  //             ),
  //           ],
  //         ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context, listen: false);
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        backgroundColor: AppColor.bg,
        title: const Text("Profile"),
        centerTitle: true,
        elevation: 0,
      ),

      // -------- STREAM BUILDER FOR REAL-TIME DATA --------
      body: StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection("service_provider")
                .doc(currentUser!.uid)
                .snapshots(),
        builder: (context, snapshot) {
          // Loading
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // If no document exists
          if (!snapshot.data!.exists) {
            return const Center(child: Text("Profile not found"));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          // Assign values
          provider.username = data["username"] ?? "";
          provider.email = data["email"] ?? "";
          provider.phone = data["phone"] ?? "";
          provider.profileImageUrl = data["profileImage"];

          return Consumer<SignUpProvider>(
            builder:
                (context, user, child) => SingleChildScrollView(
                  child: Column(
                    children: [
                      // ---------------- HEADER ----------------
                      Container(
                        width: 380,
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColor.forgot.withOpacity(0.1),
                              AppColor.forgot.withOpacity(0.5),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                // PROFILE IMAGE
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.grey.shade200,
                                  backgroundImage:
                                      user.pickedImage != null
                                          ? FileImage(user.pickedImage!)
                                          : user.profileImageUrl != null
                                          ? NetworkImage(user.profileImageUrl!)
                                          : null,
                                  child:
                                      user.pickedImage == null &&
                                              user.profileImageUrl == null
                                          ? const Icon(
                                            Icons.person,
                                            size: 60,
                                            color: Colors.grey,
                                          )
                                          : null,
                                ),

                                // EDIT BUTTON
                                // Positioned(
                                //   bottom: 0,
                                //   right: 0,
                                //   child: GestureDetector(
                                //     onTap: () => _showImagePicker(context),
                                //     child: const CircleAvatar(
                                //       backgroundColor: Colors.white,
                                //       child: Icon(
                                //         Icons.edit,
                                //         color: Colors.black,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Text(
                              user.username,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColor.blk,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              user.email,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.blk.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ---------------- DETAILS ----------------
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _infoCard(Icons.email, "Email", user.email),
                            _infoCard(Icons.phone, "Phone", user.phone),

                            SizedBox(height: 30),
                            _infoCard(Icons.settings, "Settings"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          );
        },
      ),
    );
  }

  // ---------- REUSABLE INFO CARD ----------
  Widget _infoCard(IconData icon, String label, [String? value]) {
    return Card(
      elevation: 1,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade100,
          child: Icon(icon, color: Colors.black),
        ),
        title: Text(label),
        subtitle:
            value != null && value.isNotEmpty
                ? Text(value)
                : null, // 👉 No subtitle when value is null/empty
      ),
    );
  }
}
