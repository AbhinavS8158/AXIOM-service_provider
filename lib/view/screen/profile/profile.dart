import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/user_profile_provider.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/editProfile/edit_profile.dart';
import 'package:service_provider/view/screen/profile/header_section.dart';
import 'package:service_provider/view/screen/profile/profile_info.dart';
import 'package:service_provider/view/screen/profile/settings.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.read<ProfileProvider>();

    return Scaffold(
      backgroundColor: AppColor.bg,
      body: SafeArea(
        child: StreamBuilder(
          stream: profileProvider.userStream,
          builder: (context, snapshot) {
  
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
                log(snapshot.error.toString());
              return Center(
                child: Text('Error: ${snapshot.error}'),
              
              );
            }

 
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('User data not found'));
            }

            final user = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                children: [
                  buildHeader(
                    user,
                    onEditTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditProfile(user: user),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  buildProfileInfo(user),
                  const SizedBox(height: 24),
                  buildSettings(context),
                  const SizedBox(height: 24),
                 
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
