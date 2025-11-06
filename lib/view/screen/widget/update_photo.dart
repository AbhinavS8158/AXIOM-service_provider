import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/photo_picker_provider.dart';
import 'package:service_provider/model/properycard_form_model.dart';
import 'package:service_provider/view/screen/widget/bottom_sheet.dart';

class UpdatePhoto extends StatelessWidget {
  final PropertycardFormModel? property;

  const UpdatePhoto({super.key, this.property});

  void _showCustomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CustomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<PhotoPickerProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      imageProvider.setInitialPhotos(property!.photoPath);
    });
    return Consumer<PhotoPickerProvider>(
      builder: (context, photoProvider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Property Photos',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (photoProvider.updatePhotos.isEmpty)
                      photoProvider.isLoading
                          ? CircularProgressIndicator()
                          : _buildEmptyState(context)
                    else
                      buildPhotoGrid(property!, photoProvider),
                    _buildAddButton(context),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 4),
                child: Text(
                  'Add up to 10 photos of your property',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCustomSheet(context),
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          border: Border.all(color: Colors.blue.shade100, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 80,
              color: Colors.blue.shade300,
            ),
            const SizedBox(height: 12),
            Text(
              'Add Property Photos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'High-quality photos attract more customers',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPhotoGrid(PropertycardFormModel property, PhotoPickerProvider photoPicker) {
    return Consumer<PhotoPickerProvider>(
      builder: (context, photoPicker, child) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: photoPicker.updatePhotos.length,
            itemBuilder: (context, index) {
              final path = photoPicker.updatePhotos[index];
              final isNetwork = path.startsWith('http');
              log('Photo path: $path');

              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: isNetwork
                        ? Image.network(
                            path,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                          )
                        : Image.file(
                            File(path),
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                          ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          log('Removing photo at index: $index');
                          photoPicker.removeInitialPhotos(index);
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Consumer<PhotoPickerProvider>(
      builder: (context, photoProvider, child) {
        if (photoProvider.updatePhotos.length >= 10) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.all(photoProvider.updatePhotos.isEmpty ? 0 : 12),
          child: InkWell(
            onTap: () => _showCustomSheet(context),
            borderRadius: BorderRadius.vertical(
              bottom: const Radius.circular(12),
              top: photoProvider.updatePhotos.isEmpty
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
            ),
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.vertical(
                  bottom: const Radius.circular(12),
                  top: photoProvider.updatePhotos.isEmpty
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.blue.shade700,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      photoProvider.updatePhotos.isEmpty
                          ? 'Add Photos'
                          : 'Add More Photos (${photoProvider.updatePhotos.length}/10)',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}