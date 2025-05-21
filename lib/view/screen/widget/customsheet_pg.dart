import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/photo_picker_provider_pg.dart';
import 'package:service_provider/model/option_card_model.dart';
import 'package:service_provider/view/screen/widget/option_card.dart';

class CustomsheetPg extends StatelessWidget {
  const CustomsheetPg({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Select Image',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: OptionCard(
                        title: 'Camera',
                        model: OptionCardModel(icon: Icons.camera_alt_rounded,
                         title: 'Camera', 
                         color:  Colors.blue.shade100, 
                         iconColor:  Colors.blue.shade700, onTap:  () {
                          Navigator.pop(context);
                          Provider.of<PhotoPickerProviderPg>(context, listen: false)
                              .pickImage(ImageSource.camera);
                        },),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OptionCard(
                        model: OptionCardModel(icon: Icons.photo_library_rounded,
                         title: 'Gallery', color: Colors.purple.shade100,
                          iconColor: Colors.purple.shade700, onTap:  () {
                          Navigator.pop(context);
                          Provider.of<PhotoPickerProviderPg>(context, listen: false)
                              .pickImage(ImageSource.gallery);
                        },), title: 'Gallery',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey.shade700,
                    backgroundColor: Colors.grey.shade200,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 0),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
