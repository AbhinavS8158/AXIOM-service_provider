// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/cloudinary/cloudinary.dart';
import 'package:service_provider/controller/provider/amenity_rental_provider.dart';
import 'package:service_provider/controller/provider/location_provider.dart';
import 'package:service_provider/controller/provider/photo_picker_provider.dart';
import 'package:service_provider/controller/provider/property_type_.dropdown.dart';
import 'package:service_provider/controller/provider/rental_form_provider.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/rentalProperty%20List/rental_property_listing.dart';
import 'package:service_provider/view/screen/widget/add_photo.dart';
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

class AddRentalForm extends StatelessWidget {
  const AddRentalForm({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure the form and related providers are cleared once when the page opens.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final rent = context.read<RentalFormProvider>();
        // prefer full clearAllFields() if implemented; fallback to resetForm()
        try {
          rent.clearAllFields();
        } catch (_) {
          rent.resetForm();
        }

        try {
          final photo = context.read<PhotoPickerProvider>();
          photo.clearImages();
        } catch (_) {}

        try {
          final pt = context.read<PropertyTypeProvider>();
          pt.clearSelections();
        } catch (_) {}

        try {
          final loc = context.read<LocationProvider>();
          loc.resetLocation();
        } catch (_) {}

        try {
          final am = context.read<AmenitiesProvider>();
          am.clearSelectedAmenities();
          am.resetSyncFlag();
        } catch (_) {}
      } catch (_) {
        // ignore any error during the defensive reset
      }
    });

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColor.bg,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background animation
          SizedBox.expand(
            child: Lottie.asset(
              'assets/animation/Animation - 1746427682309.json',
              fit: BoxFit.cover,
              repeat: true,
            ),
          ),

          // Form content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // Basic details
                      const SectionHeader(
                        title: 'Basic Details',
                        icon: Icons.home_outlined,
                      ),
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FieldLabel(text: 'Name of the building'),
                            CustomTextField(
                              controller: context.read<RentalFormProvider>().nameController,
                              hint: "Name of the building",
                              icon: Icons.domain,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter building name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            const FieldLabel(text: 'Property type'),
                            const DropdownProperyType(),
                            const SizedBox(height: 16),
                            const AddPhoto(),
                            const SizedBox(height: 16),
                            const FieldLabel(text: 'Location'),
                            const LocationInputWidget(),
                            const SizedBox(height: 16),
                            const FieldLabel(text: 'Contact Information'),
                            CustomTextField(
                              controller: context.read<RentalFormProvider>().phonenumController,
                              hint: 'Phone number',
                              keyboardType: TextInputType.phone,
                              icon: Icons.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                  return 'Enter a valid 10-digit phone number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              controller: context.read<RentalFormProvider>().emailController,
                              hint: 'Email',
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                ).hasMatch(value)) {
                                  return 'Enter a valid email address';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Advanced details
                      const SectionHeader(
                        title: 'Advanced Details',
                        icon: Icons.settings_outlined,
                      ),
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FieldLabel(text: 'About Property'),
                            CustomTextField(
                              controller: context.read<RentalFormProvider>().aboutcontroller,
                              hint: 'About Property',
                              icon: Icons.description,
                              maxLines: 3,
                            ),
                            const SizedBox(height: 16),
                            const FieldLabel(text: 'Rental Amount'),
                            CustomTextField(
                              controller: context.read<RentalFormProvider>().amountcontroller,
                              hint: 'Amount (₹)',
                              icon: Icons.currency_rupee,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the amount';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            const FieldLabel(text: 'Room Configuration'),
                            const Row(
                              children: [
                                Expanded(child: BedroomCount()),
                                SizedBox(width: 4),
                                Expanded(child: BathroomCount()),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const FieldLabel(text: 'Furnishing Status'),
                            const DropdownFurnished(),
                            const SizedBox(height: 16),
                            const FieldLabel(text: 'Power Backup'),
                            const DropdownPowerbackup(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Amenities
                      const SectionHeader(
                        title: 'Amenities',
                        icon: Icons.star_border_outlined,
                      ),
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                'Select available amenities',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            AmenitiesGrid(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Submit button
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Consumer<RentalFormProvider>(
                          builder: (context, rentFormProvider, _) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                              ),
                              onPressed: rentFormProvider.isLoading
                                  ? null
                                  : () async {
                                      // Validate form
                                      if (!formKey.currentState!.validate()) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Row(
                                              children: const [
                                                Icon(Icons.error_outline, color: Colors.white),
                                                SizedBox(width: 10),
                                                Text("Please fill all required fields correctly."),
                                              ],
                                            ),
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            duration: const Duration(seconds: 2),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        );
                                        return;
                                      }

                                      try {
                                        rentFormProvider.setLoading(true);

                                        final propertyTypeProvider = context.read<PropertyTypeProvider>();
                                        final locationProvider = context.read<LocationProvider>();
                                        final photoPickerProvider = context.read<PhotoPickerProvider>();
                                        final amenitiesProvider = context.read<AmenitiesProvider>();

                                        // Bedroom & Bathroom check
                                        if (propertyTypeProvider.bedroom <= 0 || propertyTypeProvider.bathroom <= 0) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Please select at least one bedroom and bathroom"),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          return;
                                        }

                                        // Photo check
                                        if (photoPickerProvider.images.isEmpty) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Please upload at least one property photo."),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          return;
                                        }

                                        // Location check
                                        if (locationProvider.locationController.text.isEmpty) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Please enter the property location."),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          return;
                                        }

                                        // Upload photos
                                        List<String> imageUrls = [];
                                        for (var image in photoPickerProvider.images) {
                                          try {
                                            String url = await CloudinaryService().uploadImage(image);
                                            imageUrls.add(url);
                                          } catch (e) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text("Failed to upload image: $e"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            return;
                                          }
                                        }

                                        // Save data into provider
                                        rentFormProvider
                                          ..setName(rentFormProvider.nameController.text)
                                          ..setPropertyType(propertyTypeProvider.selectedPropertyType ?? '')
                                          ..setLocation(locationProvider.locationController.text)
                                          ..setPhone(rentFormProvider.phonenumController.text)
                                          ..setEmail(rentFormProvider.emailController.text)
                                          ..setAbout(rentFormProvider.aboutcontroller.text)
                                          ..setAmount(rentFormProvider.amountcontroller.text)
                                          ..setFurnished(propertyTypeProvider.furnished ?? '')
                                          ..setPowerbackup(propertyTypeProvider.powerbackup ?? '')
                                          ..setPhotoPath(imageUrls)
                                          ..setAmenities(
                                            amenitiesProvider
                                                .getSelectedAmenities()
                                                .map((e) => {'name': e})
                                                .toList(),
                                          )
                                          ..setBedroom(propertyTypeProvider.bedroom.toString())
                                          ..setBathroom(propertyTypeProvider.bathroom.toString());

                                        // Upload to Firestore
                                        await rentFormProvider.addtodb(context);

                                        // Reset form & providers
                                        rentFormProvider.resetForm();
                                        try {
                                          photoPickerProvider.clearImages();
                                        } catch (_) {}
                                        try {
                                          propertyTypeProvider.clearSelections();
                                        } catch (_) {}
                                        try {
                                          locationProvider.resetLocation();
                                        } catch (_) {}
                                        try {
                                          amenitiesProvider.clearSelectedAmenities();
                                          amenitiesProvider.resetSyncFlag();
                                        } catch (_) {}

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Row(
                                              children: const [
                                                Icon(Icons.check_circle, color: Colors.white),
                                                SizedBox(width: 10),
                                                Text('Property added successfully!'),
                                              ],
                                            ),
                                            backgroundColor: Colors.green,
                                            behavior: SnackBarBehavior.floating,
                                            duration: const Duration(seconds: 2),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        );

                                        // Navigate to listing
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const RentPropertyListingScreen(),
                                          ),
                                        );
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
                              child: rentFormProvider.isLoading
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.real_estate_agent),
                                        SizedBox(width: 8),
                                        Text(
                                          'List Property For Rent',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
