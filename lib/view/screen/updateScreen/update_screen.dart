import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/cloudinary/cloudinary.dart';
import 'package:service_provider/controller/provider/amenity_rental_provider.dart';
import 'package:service_provider/controller/provider/location_provider.dart';
import 'package:service_provider/controller/provider/photo_picker_provider.dart';
import 'package:service_provider/controller/provider/property_type_.dropdown.dart';
import 'package:service_provider/controller/provider/rental_form_provider.dart';
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

class UpdateRentalForm extends StatelessWidget {
  final PropertycardFormModel property;

  const UpdateRentalForm({super.key, required this.property});

  void _maybeInitializeProviders(BuildContext context) {
    final rentalFormProvider = Provider.of<RentalFormProvider>(context, listen: false);
    final propertyTypeProvider = Provider.of<PropertyTypeProvider>(context, listen: false);
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final photoPickerProvider = Provider.of<PhotoPickerProvider>(context, listen: false);
    final amenitiesProvider = Provider.of<AmenitiesProvider>(context, listen: false);

    final needsInit = !rentalFormProvider.isInitialized || (rentalFormProvider.documentId != property.id);

    if (!needsInit) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
  
        rentalFormProvider.initializeFromProperty(property);
        rentalFormProvider.documentId = property.id;

    
        try {
          propertyTypeProvider.initializeFromProperty(property);
        } catch (_) {}

        
        if ((locationProvider.locationController.text).isEmpty && (property.location?.isNotEmpty ?? false)) {
          locationProvider.locationController.text = property.location ?? '';
        }

      
        try {
          photoPickerProvider.updatePhotos = List<String>.from(property.photoPath ?? []);
        } catch (_) {}

        try {
          amenitiesProvider.setSelectedFromProperty(property.amenities);
        } catch (_) {}
      } catch (_) {

      }
    });
  }

  Future<void> _confirmAndDelete(BuildContext context, RentalFormProvider rentProvider) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm delete'),
        content: const Text('Are you sure you want to delete this property? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Delete')),
        ],
      ),
    );

    if (shouldDelete != true) return;

    try {
      rentProvider.setLoading(true);
      await rentProvider.deleteRentalDataById(property.id!);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Property deleted successfully.'), backgroundColor: Colors.green),
      );

 
      Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete property: $e'), backgroundColor: Colors.red),
      );
    } finally {
      rentProvider.setLoading(false);
    }
  }


  void _clearFormState(BuildContext context) {

    final rentProvider = Provider.of<RentalFormProvider>(context, listen: false);
    try {
      rentProvider.clearAllFields();
    } catch (_) {
      
      try {
        rentProvider.resetForm();
        rentProvider.isInitialized = false;
        rentProvider.documentId = null;
      } catch (_) {}
    }

    
    final propertyTypeProvider = Provider.of<PropertyTypeProvider>(context, listen: false);
    try {
      propertyTypeProvider.clearSelections();
    } catch (_) {}

    
    final amenitiesProvider = Provider.of<AmenitiesProvider>(context, listen: false);
    try {
      amenitiesProvider.clearSelectedAmenities();
      amenitiesProvider.resetSyncFlag();
    } catch (_) {}

    final photoPickerProvider = Provider.of<PhotoPickerProvider>(context, listen: false);
    try {
      photoPickerProvider.clearAll(); 
    } catch (_) {
      try {
        photoPickerProvider.updatePhotos = [];
      } catch (_) {}
    }

    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    try {
      locationProvider.locationController.clear();
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    _maybeInitializeProviders(context);

    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final propertyTypeProvider = Provider.of<PropertyTypeProvider>(context, listen: false);
    final photoPickerProvider = Provider.of<PhotoPickerProvider>(context, listen: false);
    final amenitiesProvider = Provider.of<AmenitiesProvider>(context, listen: false);
    final rentalFormProvider = Provider.of<RentalFormProvider>(context, listen: false);

    final formKey = rentalFormProvider.formKey;
    final cloudinary = CloudinaryService();

    final bool isApproved = property.status?.toString() == '1';

    Widget buildUpdateButton() {
      return Expanded(
        child: Consumer<RentalFormProvider>(
          builder: (context, rentFormProvider, _) {
            return ElevatedButton(
              onPressed: rentFormProvider.isLoading
                  ? null
                  : () async {
                      if (!formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fix the errors in the form."),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      rentFormProvider.setLoading(true);

                      try {
                        if (propertyTypeProvider.bedroom <= 0 || propertyTypeProvider.bathroom <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please select at least one bedroom and bathroom"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          rentFormProvider.setLoading(false);
                          return;
                        }

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
                                  SnackBar(content: Text("Failed to upload image: $e"), backgroundColor: Colors.red),
                                );
                                rentFormProvider.setLoading(false);
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

                        rentFormProvider
                          ..setName(rentFormProvider.nameController.text)
                          ..setPropertyType(propertyTypeProvider.selectedPropertyType?.toString() ?? property.propertyType)
                          ..setLocation(locationProvider.locationController.text)
                          ..setPhone(rentFormProvider.phonenumController.text)
                          ..setEmail(rentFormProvider.emailController.text)
                          ..setAbout(rentFormProvider.aboutcontroller.text)
                          ..setFurnished(propertyTypeProvider.furnished?.toString() ?? property.furnished)
                          ..setPowerbackup(propertyTypeProvider.powerbackup?.toString() ?? property.powerbackup)
                          ..setAmount(rentFormProvider.amountcontroller.text)
                          ..setPhotoPath(finalImageUrls)
                          ..setAmenities(amenitiesProvider.getSelectedAmenities().map((e) => {'name': e}).toList())
                          ..setBedroom(propertyTypeProvider.bedroom?.toString() ?? property.bedroom)
                          ..setBathroom(propertyTypeProvider.bathroom?.toString() ?? property.bathroom);

                        await rentFormProvider.update(property.id!);

                        _clearFormState(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Property updated successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );

                        Navigator.pop(context, property);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } finally {
                        rentFormProvider.setLoading(false);
                      }
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.deepPurple,
              ),
              child: rentFormProvider.isLoading
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
      );
    }


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
                      FieldLabel(text: 'Name of the building'),
                      CustomTextField(
                        controller: rentalFormProvider.nameController,
                        hint: 'Name of the building',
                        icon: Icons.domain,
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Please enter building name' : null,
                      ),
                      const SizedBox(height: 16),
                      FieldLabel(text: 'Property type'),
                      DropdownProperyType(property: property),
                      const SizedBox(height: 16),
                      FieldLabel(text: 'Photos'),
                      UpdatePhoto(property: property),
                      const SizedBox(height: 16),
                      const FieldLabel(text: 'Location'),
                      const LocationInputWidget(),
                      const SizedBox(height: 16),
                      FieldLabel(text: 'Contact Information'),
                      CustomTextField(
                        controller: rentalFormProvider.phonenumController,
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
                        controller: rentalFormProvider.emailController,
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
                      FieldLabel(text: 'About Property'),
                      CustomTextField(
                        controller: rentalFormProvider.aboutcontroller,
                        hint: 'About Property',
                        icon: Icons.description,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      FieldLabel(text: 'Rental Amount'),
                      CustomTextField(
                        controller: rentalFormProvider.amountcontroller,
                        hint: 'Amount (₹)',
                        icon: Icons.currency_rupee,
                        keyboardType: TextInputType.number,
                        validator: (value) => value == null || value.isEmpty ? 'Enter amount' : null,
                      ),
                      const SizedBox(height: 16),
                      FieldLabel(text: 'Room Configuration'),
                      Row(
                        children: [
                          Expanded(child: BedroomCount(property: property)),
                          const SizedBox(width: 4),
                          Expanded(child: BathroomCount(property: property)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      FieldLabel(text: 'Furnishing Status'),
                      DropdownFurnished(property: property),
                      const SizedBox(height: 16),
                      FieldLabel(text: 'Power Backup'),
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

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                 child:  Row(
                          children: [
                            buildUpdateButton(),
                            const SizedBox(width: 12),
                          
                          ],
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
