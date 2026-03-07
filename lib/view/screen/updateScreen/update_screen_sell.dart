import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/cloudinary/cloudinary.dart';
import 'package:service_provider/controller/provider/amenity_rental_provider.dart';
import 'package:service_provider/controller/provider/location_provider.dart';
import 'package:service_provider/controller/provider/photo_picker_provider.dart';
import 'package:service_provider/controller/provider/property_type_.dropdown.dart';
import 'package:service_provider/controller/provider/sell_form_provider.dart';
import 'package:service_provider/model/propertycard_form_model.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/widget/amenity_grid.dart';
import 'package:service_provider/view/screen/widget/bathroom_count.dart';
import 'package:service_provider/view/screen/widget/bedroom_count.dart';
import 'package:service_provider/view/screen/widget/custom_card.dart';
import 'package:service_provider/view/screen/widget/dropdown_furnished.dart';
import 'package:service_provider/view/screen/widget/dropdown_powerbackup.dart';
import 'package:service_provider/view/screen/widget/dropdown_propery_type.dart';
import 'package:service_provider/view/screen/widget/field_label.dart';
import 'package:service_provider/view/screen/widget/location_input_widget.dart';
import 'package:service_provider/view/screen/widget/section_header.dart';
import 'package:service_provider/view/screen/widget/textfield.dart';
import 'package:service_provider/view/screen/widget/update_photo.dart';

class UpdateSellForm extends StatelessWidget {
  final PropertycardFormModel property;

  const UpdateSellForm({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final propertyTypeProvider = Provider.of<PropertyTypeProvider>(context, listen: false);
    propertyTypeProvider.initializeFromProperty(property);
    final photoPickerProvider = Provider.of<PhotoPickerProvider>(context, listen: false);
    final amenitiesProvider = Provider.of<AmenitiesProvider>(context, listen: false);
    final sellFormProvider = Provider.of<SellFormProvider>(context, listen: false);

    if (sellFormProvider.nameController.text.isEmpty) {
      sellFormProvider.nameController.text = property.name ?? '';
    }
    if (sellFormProvider.phonenumController.text.isEmpty) {
      sellFormProvider.phonenumController.text = property.phoneNumber ?? '';
    }
    if (sellFormProvider.emailController.text.isEmpty) {
      sellFormProvider.emailController.text = property.email ?? '';
    }
    if (sellFormProvider.aboutController.text.isEmpty) {
      sellFormProvider.aboutController.text = property.about ?? '';
    }
    if (sellFormProvider.amountController.text.isEmpty) {
      sellFormProvider.amountController.text = property.amount?.toString() ?? '';
    }
    if (locationProvider.locationController.text.isEmpty) {
      locationProvider.locationController.text = property.location ?? '';
    }

    final formKey = sellFormProvider.formKey;
    final cloudinary = CloudinaryService();

    return Scaffold(
      backgroundColor: AppColor.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const SectionHeader(
                  title: 'Update Property',
                  icon: Icons.edit_location_alt,
                ),
                CustomCard(
                  child: Column(
                    children: [
                      const FieldLabel(text: 'Name of the building'),
                      CustomTextField(
                        controller: sellFormProvider.nameController,
                        hint: 'Name of the building',
                        icon: Icons.domain,
                        validator: (value) => value == null || value.isEmpty ? 'Please enter building name' : null,
                      ),
                      const SizedBox(height: 16),
                      const FieldLabel(text: 'Property type'),
                      DropdownProperyType(property: property),
                      const SizedBox(height: 16),
                      const FieldLabel(text: 'Photos'),
                      UpdatePhoto(property: property),
                      const SizedBox(height: 16),
                      const FieldLabel(text: 'Location'),
                      const LocationInputWidget(),
                      const SizedBox(height: 16),
                      const FieldLabel(text: 'Contact Information'),
                      CustomTextField(
                        controller: sellFormProvider.phonenumController,
                        hint: 'Phone number',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Please enter your phone number';
                          if (!RegExp(r'^\d{10}$').hasMatch(value)) return 'Enter valid 10-digit number';
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: sellFormProvider.emailController,
                        hint: 'Email',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Please enter your email';
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Enter valid email';
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                const SectionHeader(title: 'Advanced Details', icon: Icons.settings),
                CustomCard(
                  child: Column(
                    children: [
                      const FieldLabel(text: 'About Property'),
                      CustomTextField(
                        controller: sellFormProvider.aboutController,
                        hint: 'About Property',
                        icon: Icons.description,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      const FieldLabel(text: 'Price'),
                      CustomTextField(
                        controller: sellFormProvider.amountController,
                        hint: 'Amount (₹)',
                        icon: Icons.currency_rupee,
                        keyboardType: TextInputType.number,
                        validator: (value) => value == null || value.isEmpty ? 'Enter amount' : null,
                      ),
                      const SizedBox(height: 16),
                      const FieldLabel(text: 'Room Configuration'),
                      Row(
                        children: [
                          Expanded(child: BedroomCount(property: property)),
                          const SizedBox(width: 4),
                          Expanded(child: BathroomCount(property: property)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const FieldLabel(text: 'Furnishing Status'),
                      DropdownFurnished(property: property),
                      const SizedBox(height: 16),
                      const FieldLabel(text: 'Power Backup'),
                      DropdownPowerbackup(property: property),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                const SectionHeader(title: 'Amenities', icon: Icons.star_border),
                CustomCard(child: AmenitiesGrid(property: property)),
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: Consumer<SellFormProvider>(
                    builder: (context, sellProvider, _) {
                      return ElevatedButton(
                        onPressed: sellProvider.isLoading
                            ? null
                            : () async {
                                if (!formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please fix the errors in the form.'), backgroundColor: Colors.red),
                                  );
                                  return;
                                }

                                sellProvider.setLoading(true);
                                try {
                                  final List<String> finalImageUrls = [];
                                  final imagesList = photoPickerProvider.images; 
                                  final urlsList = photoPickerProvider.updatePhotos;

                                  final maxLen = imagesList.length > urlsList.length ? imagesList.length : urlsList.length;

                                  for (var i = 0; i < maxLen; i++) {
                                    if (i < urlsList.length && urlsList[i].isNotEmpty) {
                                      finalImageUrls.add(urlsList[i]);
                                      continue;
                                    }

                                    if (i < imagesList.length) {
                                      final item = imagesList[i];
                                      if (item is File) {
                                        try {
                                          final uploaded = await cloudinary.uploadImage(item);
                                          finalImageUrls.add(uploaded);
                                        } catch (e) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Failed to upload image: $e'), backgroundColor: Colors.red),
                                          );
                                          sellProvider.setLoading(false);
                                          return;
                                        }
                                      } else {
                                        continue; 
                                      }
                                    }
                                  }

                                  if (finalImageUrls.isEmpty && property.photoPath != null && property.photoPath!.isNotEmpty) {
                                    finalImageUrls.addAll(property.photoPath!);
                                  }

                          
                                  sellProvider
                                    ..setName(sellProvider.nameController.text)
                                    ..setPropertyType(propertyTypeProvider.selectedPropertyType?.toString() ?? property.propertyType)
                                    ..setLocation(locationProvider.locationController.text)
                                    ..setPhone(sellProvider.phonenumController.text)
                                    ..setEmail(sellProvider.emailController.text)
                                    ..setAbout(sellProvider.aboutController.text)
                                    ..setFurnished(propertyTypeProvider.furnished?.toString() ?? property.furnished)
                                    ..setPowerbackup(propertyTypeProvider.powerbackup?.toString() ?? property.powerbackup)
                                    ..setAmount(sellProvider.amountController.text)
                                    ..setAmenities(amenitiesProvider.getSelectedAmenities().map((e) => {'name': e}).toList())
                                    ..setBathroom(propertyTypeProvider.bathroom?.toString() ?? property.bathroom)
                                    ..setBedroom(propertyTypeProvider.bedroom?.toString() ?? property.bedroom)
                                    ..setPhotoPath(finalImageUrls);

                                  await sellProvider.update(property.id!);

                                  propertyTypeProvider.clearSelections();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Property updated successfully!'), backgroundColor: Colors.green),
                                  );

                                  Navigator.pop(context, property);
                                } catch (e, st) {
                                  log('UpdateSellForm error: $e\n$st');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
                                  );
                                } finally {
                                  sellProvider.setLoading(false);
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: sellProvider.isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text('Update', style: TextStyle(color: Colors.white)),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
