import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_provider/controller/cloudinary/cloudinary.dart';

class PhotoPickerProviderPg extends ChangeNotifier {
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();
  final CloudinaryService _cloudinaryService=CloudinaryService();
  
  List<File> get images => _images;
  
  Future<void> pickImage(ImageSource source) async {
    try {
      // Limit to 10 images
      if (_images.length >= 10) {
        return;
      }
      
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80, // Reduce quality to save space
      );
      
      if (pickedFile != null) {
     final imageFile=File(pickedFile.path);
     final imageUrl=await _cloudinaryService.uploadImage(imageFile);
     _images.add(imageFile);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }
  
  // Add support for multiple images
  Future<void> pickMultipleImages() async {
    try {
      // Calculate how many images we can still add
      final int remainingSlots = 10 - _images.length;
      
      if (remainingSlots <= 0) {
        return;
      }
      
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: 80,
      );
      
      // Only add up to our limit
      final filesToAdd = pickedFiles.take(remainingSlots).toList();
      
      if (filesToAdd.isNotEmpty) {
        for(var pickedFile in filesToAdd){
          final imageFile=File(pickedFile.path);
          final imageUrl =await _cloudinaryService.uploadImage(imageFile);
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