import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/edit_profile_provider.dart';
import 'package:service_provider/model/signup_model.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/editProfile/widget/profile_form.dart';
import 'package:service_provider/view/screen/editProfile/widget/profile_image_picker.dart';

class EditProfile extends StatelessWidget {
  final SignUpModel user;

  const EditProfile({super.key, required this.user});

  void _showImageSourceDialog(
    BuildContext context,
    EditProfileProvider provider,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (_) => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    provider.pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    provider.pickImage(ImageSource.gallery);
                  },
                ),
                if (provider.pickedImage != null || user.profileImage != null)
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.red),
                    title: const Text('Remove Photo'),
                    onTap: () {
                      Navigator.pop(context);
                      provider.removeImage();
                    },
                  ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileProvider()..init(user),
      child: Consumer<EditProfileProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColor.bg,
            appBar: AppBar(
              backgroundColor: AppColor.forgot,
              title: const Text('Edit Profile'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  ProfileImagePicker(
                    pickedImage: provider.pickedImage,
                    networkImageUrl: user.profileImage,
                    onPickImage: () {
                      _showImageSourceDialog(context, provider);
                    },
                  ),

                  ProfileForm(
                    nameController: provider.nameController,
                    emailController: provider.emailController,
                    phoneController: provider.phoneController,
                    isLoading: provider.isLoading,
                    onSubmit: () => provider.updateProfile(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
