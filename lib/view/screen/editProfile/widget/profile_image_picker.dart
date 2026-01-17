import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImagePicker extends StatelessWidget {
  final File? pickedImage;
  final String? networkImageUrl;
  final VoidCallback onPickImage;

  const ProfileImagePicker({
    super.key,
    required this.pickedImage,
    required this.networkImageUrl,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: _getBackgroundImage(),
          child: _showPlaceholderIcon()
              ? const Icon(Icons.person, size: 60, color: Colors.grey)
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onPickImage,
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.camera_alt, size: 18),
            ),
          ),
        ),
      ],
    );
  }

  ImageProvider? _getBackgroundImage() {
    if (pickedImage != null) {
      return FileImage(pickedImage!);
    } else if (networkImageUrl != null && networkImageUrl!.isNotEmpty) {
      return NetworkImage(networkImageUrl!);
    }
    return null;
  }

  bool _showPlaceholderIcon() {
    return pickedImage == null &&
        (networkImageUrl == null || networkImageUrl!.isEmpty);
  }
}
