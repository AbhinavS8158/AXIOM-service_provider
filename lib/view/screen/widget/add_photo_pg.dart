import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/photo_picker_provider_pg.dart';
import 'package:service_provider/view/screen/widget/customsheet_pg.dart';


class AddPhotoPg extends StatelessWidget {
  const AddPhotoPg({super.key});

  void _showCustomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const CustomsheetPg(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotoPickerProviderPg>(
      builder: (context, photoProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Property Photos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
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
                  if (photoProvider.images.isEmpty)
                    _buildEmptyPgState(context)
                  else
                    _buildPhotoGrid(photoProvider),
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
        );
      },
    );
  }

  Widget _buildEmptyPgState(BuildContext context) {
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

  Widget _buildPhotoGrid(PhotoPickerProviderPg photoProvider) {
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
        itemCount: photoProvider.images.length,
        itemBuilder: (context, index) {
          final File imageFile = photoProvider.images[index];
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  imageFile,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => photoProvider.removeImage(index),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Consumer<PhotoPickerProviderPg>(
      builder: (context, photoProvider, child) {
        if (photoProvider.images.length >= 10) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.all(photoProvider.images.isEmpty ? 0 : 12),
          child: InkWell(
            onTap: () => _showCustomSheet(context),
            borderRadius: BorderRadius.vertical(
              bottom: const Radius.circular(12),
              top: photoProvider.images.isEmpty
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
            ),
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.vertical(
                  bottom: const Radius.circular(12),
                  top: photoProvider.images.isEmpty
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
                      photoProvider.images.isEmpty
                          ? 'Add Photos'
                          : 'Add More Photos (${photoProvider.images.length}/10)',
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
