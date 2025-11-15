import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_provider/controller/cloudinary/cloudinary.dart';

class PhotoPickerProviderSell extends ChangeNotifier {
  bool isLoading = false;
  final List<File> _images = [];
  List<String> updatePhotos = [];
  final ImagePicker _picker = ImagePicker();

  // Assuming CloudinaryService exists and is functional
  final CloudinaryService _cloudinaryService = CloudinaryService();

  List<File> get images => _images;

  /// 📸 Single image from Camera or Gallery
  Future<void> pickImage(ImageSource source) async {
    try {
      if (_images.length >= 10) return;

      isLoading = true;
      notifyListeners();

      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        // Note: Mock Cloudinary service will return a placeholder URL
        final imageUrl = await _cloudinaryService.uploadImage(imageFile);

        _images.add(imageFile);
        updatePhotos.add(imageUrl);
      }
    } catch (e) {
      debugPrint('❌ Error picking image: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// 🖼️ Multiple image picker (Gallery)
  Future<void> pickMultipleImages() async {
    try {
      final remainingSlots = 10 - _images.length;
      if (remainingSlots <= 0) {
        debugPrint('Maximum 10 images reached.');
        return;
      }

      isLoading = true;
      notifyListeners();

      // Pick multiple images from gallery
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: 80,
      );

      if (pickedFiles.isEmpty) {
        isLoading = false;
        notifyListeners();
        return;
      }

      // Limit to remaining allowed slots
      final filesToAdd = pickedFiles.take(remainingSlots).toList();

      // 🚀 Upload all in parallel
      final uploadResults = await Future.wait(
        filesToAdd.map((pickedFile) async {
          final imageFile = File(pickedFile.path);
          // Note: Mock Cloudinary service will return a placeholder URL
          final imageUrl = await _cloudinaryService.uploadImage(imageFile);
          return {'file': imageFile, 'url': imageUrl};
        }),
      );

      for (var result in uploadResults) {
        _images.add(result['file'] as File);
        updatePhotos.add(result['url'] as String);
      }

      log('✅ Uploaded ${uploadResults.length} images');
    } catch (e) {
      debugPrint('❌ Error picking multiple images: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// 🔄 Update existing image at specific index
  Future<void> updateImage(int index, ImageSource source) async {
    try {
      if (index < 0 || index >= _images.length) return;

      isLoading = true;
      notifyListeners();

      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        final newImageFile = File(pickedFile.path);
        final newImageUrl = await _cloudinaryService.uploadImage(newImageFile);

        _images[index] = newImageFile;
        if (index < updatePhotos.length) {
          updatePhotos[index] = newImageUrl;
        } else {
          updatePhotos.add(newImageUrl);
        }

        log('🔁 Updated image at index $index');
      }
    } catch (e) {
      debugPrint('❌ Error updating image: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// ❌ Remove image and its Cloudinary URL
  void removeImage(int index) {
    if (index >= 0 && index < _images.length) {
      _images.removeAt(index);
      if (index < updatePhotos.length) updatePhotos.removeAt(index);
      log('🗑️ Removed image at index $index');
      notifyListeners();
    }
  }

  /// 📷 For editing pre-existing Cloudinary images
  void setInitialPhotos(List<String> photos) {
    updatePhotos
      ..clear()
      ..addAll(photos);
    notifyListeners();
  }

  void removeInitialPhotos(int index) {
    if (index >= 0 && index < updatePhotos.length) {
      updatePhotos.removeAt(index);
      notifyListeners();
    }
  }

  /// 🧹 Clear all picked images and URLs
  void clearImages() {
    _images.clear();
    updatePhotos.clear();
    notifyListeners();
  }
}
