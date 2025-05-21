import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_provider/controller/cloudinary/cloudinary.dart';


class PhotoPickerProvider extends ChangeNotifier {
  bool isLoading=false;
  final List<File> _images = []; 
  List<String> updatePhotos=[];
  final ImagePicker _picker = ImagePicker();
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

        
        final imageUrl = await _cloudinaryService.uploadImage(imageFile);

      
        _images.add(imageFile); 
        isLoading=false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }
  Future<void> pickUpdateImages(ImageSource source) async {
    try {
      if (_images.length >= 10) {
        return;
      }isLoading=true;notifyListeners();
log('hello called anto');
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);

        
        final imageUrl = await _cloudinaryService.uploadImage(imageFile);
isLoading=false;
      print('updateImageUrl $imageUrl');
        updatePhotos.add(imageUrl); 
        log(updatePhotos.toString());
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

          // Upload image to Cloudinary using the unsigned upload method
          final imageUrl = await _cloudinaryService.uploadImage(imageFile);

          // You can store the Cloudinary URL or the local file depending on your use case
          _images.add(imageFile); // Or store imageUrl if you prefer
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking multiple images: $e');
    }
  }
  void removeImage(int index) {
    if (index >= 0 && index < _images.length) {
      log('images is $_images');
      _images.removeAt(index);
      notifyListeners();
    }
  }
 void setInitialPhotos(List<String>photos){
  updatePhotos.clear();
   updatePhotos.addAll(photos);
   notifyListeners();
 }
 void removeInitialPhotos(int index){
  updatePhotos.removeAt(index);
  notifyListeners();
 }


  void clearImages() {
    _images.clear();
    notifyListeners();
  }



  ////////////////////////////
  Future<void> updateImage(int index, ImageSource source) async {
    try {
      if (index < 0 || index >= _images.length) return;

      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        final newImageFile = File(pickedFile.path);
        final newImageUrl = await _cloudinaryService.uploadImage(newImageFile);

        _images[index] = newImageFile; // Or use newImageUrl
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating image: $e');
    }
  }
}
