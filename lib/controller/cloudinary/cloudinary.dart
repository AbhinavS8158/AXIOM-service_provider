import 'dart:developer';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
class CloudinaryService {
  final CloudinaryPublic cloudinary = CloudinaryPublic('ditqrbrs1', 'my_file'); 

  Future<String> uploadImage(File imageFile) async {
    try {
      final response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imageFile.path,
          resourceType: CloudinaryResourceType.Image,
        ),
        uploadPreset: 'my_file', 
      );

      log(response.secureUrl);
      return response.secureUrl;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }
}
