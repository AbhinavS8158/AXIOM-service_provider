import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_provider/controller/cloudinary/cloudinary.dart';

class PhotoPickerProviderSell extends ChangeNotifier {
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();
  // ignore: unused_field
  final CloudinaryService _cloudinaryService = CloudinaryService();

  List<File> get images => _images;

  Future<void> pickImage(ImageSource source) async {
    try {
      if (_images.length >= 10) {
        return;
      }

      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        _images.add(imageFile);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> pickMultipleImages() async {
    try {
      final int remainingSlots = 10 - _images.length;

      if (remainingSlots <= 0) {
        return;
      }

      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: 80,
      );

      final filesToAdd = pickedFiles.take(remainingSlots).toList();

      if (filesToAdd.isNotEmpty) {
        for (var pickedFile in filesToAdd) {
          final imageFile = File(pickedFile.path);
          _images.add(imageFile);
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking multiple images: $e');
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < _images.length) {
      _images.removeAt(index);
      notifyListeners();
    }
  }

  void clearImages() {
    _images.clear();
    notifyListeners();
  }
}
