import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/cloudinary/cloudinary.dart';
import 'package:service_provider/controller/provider/amenity_rental_provider.dart';
import 'package:service_provider/controller/provider/location_provider.dart';
import 'package:service_provider/controller/provider/pg_form_provider.dart';
import 'package:service_provider/controller/provider/photo_picker_provider.dart';
import 'package:service_provider/controller/provider/property_type_.dropdown.dart';
import 'package:service_provider/model/propertycard_form_model.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/widget/amenity_grid.dart';
import 'package:service_provider/view/screen/widget/bathroom_count.dart';
import 'package:service_provider/view/screen/widget/bedroom_count.dart';
import 'package:service_provider/view/screen/widget/custom_card.dart';
import 'package:service_provider/view/screen/widget/dropdown_food_pg.dart';
import 'package:service_provider/view/screen/widget/dropdown_furnished.dart';
import 'package:service_provider/view/screen/widget/dropdown_powerbackup.dart';
import 'package:service_provider/view/screen/widget/dropdown_propery_type.dart';
import 'package:service_provider/view/screen/widget/field_label.dart';
import 'package:service_provider/view/screen/widget/location_input_widget.dart';
import 'package:service_provider/view/screen/widget/section_header.dart';
import 'package:service_provider/view/screen/widget/textfield.dart';
import 'package:service_provider/view/screen/widget/update_photo.dart';

class UpdatePgForm extends StatelessWidget {
  final PropertycardFormModel property;

  const UpdatePgForm({super.key, required this.property});

  void _guardedInit(BuildContext context) {
    final pgFormProvider = Provider.of<PgFormProvider>(context, listen: false);
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final propertyTypeProvider = Provider.of<PropertyTypeProvider>(context, listen: false);
    final photoPickerProvider = Provider.of<PhotoPickerProvider>(context, listen: false);
    final amenitiesProvider = Provider.of<AmenitiesProvider>(context, listen: false);

    try {
      if (pgFormProvider.nameController.text.trim().isEmpty) {
        pgFormProvider.nameController.text = property.name ;
      }
      if (pgFormProvider.phonenumController.text.trim().isEmpty) {
        pgFormProvider.phonenumController.text = property.phoneNumber ;
      }
      if (pgFormProvider.emailController.text.trim().isEmpty) {
        pgFormProvider.emailController.text = property.email ;
      }
      if (pgFormProvider.aboutcontroller.text.trim().isEmpty) {
        pgFormProvider.aboutcontroller.text = property.about ;
      }
      if (pgFormProvider.amountcontroller.text.trim().isEmpty) {
        pgFormProvider.amountcontroller.text = property.amount.toString();
      }
      if (locationProvider.locationController.text.trim().isEmpty) {
        locationProvider.locationController.text = property.location ;
      }

      try {
        propertyTypeProvider.initializeFromProperty(property);
      } catch (e) {
        log('initializeFromProperty error: $e');
      }

      if (photoPickerProvider.updatePhotos.isEmpty && (property.photoPath != null && property.photoPath.isNotEmpty)) {
        try {
          photoPickerProvider.setInitialPhotos(List<String>.from(property.photoPath));
        } catch (e) {
          log('setInitialPhotos failed: $e');
        }
      }

      if (amenitiesProvider.getSelectedAmenities().isEmpty && property.amenities != null && property.amenities!.isNotEmpty) {
        try {
          final names = property.amenities.map((m) {
            if (m is Map && m.containsKey('name')) return m['name'].toString();
            return m.toString();
          }).toList();
          amenitiesProvider.setInitialSelectedAmenities(names);
        } catch (e) {
          log('setInitialSelectedAmenities failed: $e');
        }
      }
    } catch (e, st) {
      log('guardedInit error: $e\n$st');
    }
  }

  @override
  Widget build(BuildContext context) {
    _guardedInit(context);

    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final propertyTypeProvider = Provider.of<PropertyTypeProvider>(context, listen: false);
    final photoPickerProvider = Provider.of<PhotoPickerProvider>(context, listen: false);
    final amenitiesProvider = Provider.of<AmenitiesProvider>(context, listen: false);
    final pgFormProvider = Provider.of<PgFormProvider>(context, listen: false);

    final formKey = pgFormProvider.formKey;
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
                        controller: pgFormProvider.nameController,
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
                        controller: pgFormProvider.phonenumController,
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
                        controller: pgFormProvider.emailController,
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
                const SectionHeader(
                  title: 'Advanced Details',
                  icon: Icons.settings,
                ),
                CustomCard(
                  child: Column(
                    children: [
                      const FieldLabel(text: 'About Property'),
                      CustomTextField(
                        controller: pgFormProvider.aboutcontroller,
                        hint: 'About Property',
                        icon: Icons.description,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 12),
                      const FieldLabel(text: 'Food Availability'),
                      DropdownFoodPg(),
                      const SizedBox(height: 16),
                      const FieldLabel(text: 'Rental Amount'),
                      CustomTextField(
                        controller: pgFormProvider.amountcontroller,
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
                const SectionHeader(
                  title: 'Amenities',
                  icon: Icons.star_border,
                ),
                CustomCard(child: AmenitiesGrid(property: property)),
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: Consumer<PgFormProvider>(
                    builder: (context, pgProvider, _) {
                      return ElevatedButton(
                        onPressed: pgProvider.isLoading
                            ? null
                            : () async {
                                if (!formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please fix the errors in the form.'), backgroundColor: Colors.red),
                                  );
                                  return;
                                }

                                final bedroomStr = propertyTypeProvider.bedroom?.toString() ?? property.bedroom;
                                final bathroomStr = propertyTypeProvider.bathroom?.toString() ?? property.bathroom;
                                final bedroomOk = bedroomStr != null && bedroomStr != '0';
                                final bathroomOk = bathroomStr != null && bathroomStr != '0';
                                if (!bedroomOk || !bathroomOk) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please select at least one bedroom and bathroom'), backgroundColor: Colors.red),
                                  );
                                  return;
                                }

                                pgProvider.setLoading(true);

                                try {
                                  final List<String> finalImageUrls = [];
                                  final imagesList = photoPickerProvider.images;
                                  final urlsList = photoPickerProvider.updatePhotos;
                                  final maxLen = imagesList.length > urlsList.length ? imagesList.length : urlsList.length;

                                  for (int i = 0; i < maxLen; i++) {
                                    if (i < urlsList.length && urlsList[i].isNotEmpty) {
                                      finalImageUrls.add(urlsList[i]);
                                      continue;
                                    }

                                    if (i < imagesList.length) {
                                      final item = imagesList[i];
                                      if (item is File) {
                                        try {
                                          final uploadedUrl = await cloudinary.uploadImage(item);
                                          finalImageUrls.add(uploadedUrl);
                                        } catch (e) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Failed to upload image: $e'), backgroundColor: Colors.red),
                                          );
                                          pgProvider.setLoading(false);
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

                                  pgProvider
                                    ..setName(pgProvider.nameController.text)
                                    ..setPropertyType(propertyTypeProvider.selectedPropertyType?.toString() ?? property.propertyType)
                                    ..setLocation(locationProvider.locationController.text)
                                    ..setPhone(pgProvider.phonenumController.text)
                                    ..setEmail(pgProvider.emailController.text)
                                    ..setAbout(pgProvider.aboutcontroller.text)
                                    ..setFurnished(propertyTypeProvider.furnished?.toString() ?? property.furnished)
                                    ..setPowerbackup(propertyTypeProvider.powerbackup?.toString() ?? property.powerbackup)
                                    ..setAmount(pgProvider.amountcontroller.text)
                                    ..setAmenities(amenitiesProvider.getSelectedAmenities().map((e) => {'name': e}).toList())
                                    ..setBathroom(propertyTypeProvider.bathroom?.toString() ?? property.bathroom)
                                    ..setBedroom(propertyTypeProvider.bedroom?.toString() ?? property.bedroom)
                                    ..setPhotoPath(finalImageUrls);

                                  await pgProvider.update(property.id!);

                                  propertyTypeProvider.clearSelections();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Property updated successfully!'), backgroundColor: Colors.green),
                                  );

                                  Navigator.pop(context, property);
                                } catch (e, st) {
                                  log('UpdatePgForm error: $e\n$st');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
                                  );
                                } finally {
                                  pgProvider.setLoading(false);
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: pgProvider.isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
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
