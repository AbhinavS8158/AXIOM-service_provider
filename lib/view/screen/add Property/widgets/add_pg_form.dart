// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/cloudinary/cloudinary.dart';
import 'package:service_provider/controller/provider/amenities_pg_provider.dart';
import 'package:service_provider/controller/provider/location_provider.dart';
import 'package:service_provider/controller/provider/pg_form_provider.dart';
import 'package:service_provider/controller/provider/photo_picker_provider_pg.dart';
import 'package:service_provider/controller/provider/property_type_pg.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/pgProperty%20List/pg_property_list.dart';
import 'package:service_provider/view/screen/widget/add_photo_pg.dart';
import 'package:service_provider/view/screen/widget/amenities_pg_grid.dart';
import 'package:service_provider/view/screen/widget/bathroom_count_pg.dart';
import 'package:service_provider/view/screen/widget/bedroom_count_pg.dart';
import 'package:service_provider/view/screen/widget/custom_card.dart';
import 'package:service_provider/view/screen/widget/dropdown_food_pg.dart';
import 'package:service_provider/view/screen/widget/dropdown_furnisher_pg.dart';
import 'package:service_provider/view/screen/widget/dropdown_powerbackup_pg.dart';
import 'package:service_provider/view/screen/widget/dropdown_property_type_pg.dart';
import 'package:service_provider/view/screen/widget/field_label.dart';
import 'package:service_provider/view/screen/widget/location_input_widget.dart';
import 'package:service_provider/view/screen/widget/section_header.dart';
import 'package:service_provider/view/screen/widget/textfield.dart';

class AddPgForm extends StatelessWidget {
  AddPgForm({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Animated background
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
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      // Basic Details Section
                      SectionHeader(
                        title: 'Basic Details',
                        icon: Icons.home_outlined,
                      ),
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FieldLabel(text: 'Name of the building'),
                            CustomTextField(
                              controller:
                                  context.read<PgFormProvider>().nameController,
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
                            FieldLabel(text: 'Property type'),
                            const DropdownPropertyTypePg(),
                            const SizedBox(height: 16),
                            FieldLabel(text: 'Photos'),
                            const AddPhotoPg(),
                            const SizedBox(height: 16),
                            
const SizedBox(height: 16),
const FieldLabel(text: 'Location'),
const LocationInputWidget(), 
                            const SizedBox(height: 16),
                            FieldLabel(text: 'Contact Information'),
                            CustomTextField(
                              controller:
                                  context
                                      .read<PgFormProvider>()
                                      .phonenumController,
                              hint: 'Phone number',
                              keyboardType: TextInputType.phone,
                              icon: Icons.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                } else if (!RegExp(
                                  r'^\d{10}$',
                                ).hasMatch(value)) {
                                  return 'Enter a valid 10-digit phone number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              controller:
                                  context
                                      .read<PgFormProvider>()
                                      .emailController,
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
                      // Advanced Details Section
                      SectionHeader(
                        title: 'Advanced Details',
                        icon: Icons.settings_outlined,
                      ),
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FieldLabel(text: 'About Property'),
                            CustomTextField(
                              controller:
                                  context
                                      .read<PgFormProvider>()
                                      .aboutcontroller,
                              hint: 'About Property',
                              icon: Icons.description,
                              maxLines: 3,
                            ),
                            const SizedBox(height: 16),
                            FieldLabel(text: 'Food Availability'),
                            DropdownFoodPg(),
                            const SizedBox(height: 16),
                            FieldLabel(text: 'Monthly Rent'),
                            CustomTextField(
                              controller:
                                  context
                                      .read<PgFormProvider>()
                                      .amountcontroller,
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
                            FieldLabel(text: 'Room Configuration'),
                            Row(
                              children: const [
                                Expanded(child: BedroomCountPg()),
                                SizedBox(width: 4),
                                Expanded(child: BathroomCountPg()),
                              ],
                            ),
                            const SizedBox(height: 16),
                            FieldLabel(text: 'Furnishing Status'),
                            const DropdownFurnisherPg(),
                            const SizedBox(height: 16),
                            FieldLabel(text: 'Power Backup'),
                            const DropdownPowerbackupPg(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Amenities Section
                      SectionHeader(
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
                            AmenitiesPgGrid(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Submit Button
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Consumer<PgFormProvider>(
                          builder: (context, pgFormProvider, _) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                                disabledBackgroundColor: Colors.deepPurple
                                    .withOpacity(0.5),
                              ),
                              onPressed:
                                  pgFormProvider.isLoading
                                      ? null
                                      : () async {
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            pgFormProvider.setLoading(true);

                                            final propertyTypeProviderPg =
                                                context
                                                    .read<DropdownPgProvider>();
                                            final locationProvider =
                                                context
                                                    .read<LocationProvider>();
                                            final photoPickerProvider =
                                                context
                                                    .read<
                                                      PhotoPickerProviderPg
                                                    >();
                                            final amenitiesProviderPg =
                                                context
                                                    .read<
                                                      AmenitiesPgProvider
                                                    >();

                                            // Validate bedroom and bathroom
                                            if (propertyTypeProviderPg
                                                        .bedroom <=
                                                    0 ||
                                                propertyTypeProviderPg
                                                        .bathroom <=
                                                    0) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "Please select at least one bedroom and bathroom",
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                              return;
                                            }

                                            // Upload images to Cloudinary
                                            List<String> imageUrls = [];
                                            for (var image
                                                in photoPickerProvider.images) {
                                              try {
                                                String url =
                                                    await CloudinaryService()
                                                        .uploadImage(image);
                                                imageUrls.add(url);
                                              } catch (e) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      "Failed to upload image: $e",
                                                    ),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                                return; // Stop if image upload fails
                                              }
                                            }

                                            // Set all provider fields
                                            pgFormProvider
                                              ..setName(
                                                pgFormProvider
                                                    .nameController
                                                    .text,
                                              )
                                              ..setPropertyType(
                                                propertyTypeProviderPg
                                                        .selectedPropertyType ??
                                                    '',
                                              )
                                              ..setLocation(
                                                locationProvider
                                                    .locationController
                                                    .text,
                                              )
                                              ..setPhone(
                                                pgFormProvider
                                                    .phonenumController
                                                    .text,
                                              )
                                              ..setPhotoPath(imageUrls)
                                              ..setEmail(
                                                pgFormProvider
                                                    .emailController
                                                    .text,
                                              )
                                              ..setAbout(
                                                pgFormProvider
                                                    .aboutcontroller
                                                    .text,
                                              )
                                              ..setFurnished(
                                                propertyTypeProviderPg
                                                        .furnished ??
                                                    '',
                                              )
                                              ..setPowerbackup(
                                                propertyTypeProviderPg
                                                        .powerbackup ??
                                                    '',
                                              )
                                              ..setAmount(
                                                pgFormProvider
                                                    .amountcontroller
                                                    .text,
                                              )
                                              ..setFood(
                                                propertyTypeProviderPg.food ??
                                                    '',
                                              )
                                              ..setBathroom(
                                                propertyTypeProviderPg.bathroom
                                                    .toString(),
                                              )
                                              ..setBedroom(
                                                propertyTypeProviderPg.bedroom
                                                    .toString(),
                                              )
                                              ..setAmenities(
                                                amenitiesProviderPg
                                                    .getSelectedAmenities()
                                                    .map((e) => {'name': e})
                                                    .toList(),
                                              );

                                            // Add to Firestore
                                            await pgFormProvider.addtodb(
                                              context,
                                            );

                                            // Clear all fields after successful submission
                                            pgFormProvider.resetForm();
                                            photoPickerProvider.clearImages();
                                            propertyTypeProviderPg
                                                .resetSelections();
                                            locationProvider.resetLocation();
                                            amenitiesProviderPg
                                                .clearSelectedAmenities();

                                            // Show success message
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.check_circle,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      'PG property added successfully!',
                                                    ),
                                                  ],
                                                ),
                                                backgroundColor: Colors.green,
                                                duration: const Duration(
                                                  seconds: 2,
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            );

                                            // Navigate with animation
                                            Navigator.pushReplacement(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder:
                                                    (
                                                      context,
                                                      animation,
                                                      secondaryAnimation,
                                                    ) => const PgPropertList(),
                                                transitionsBuilder: (
                                                  context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child,
                                                ) {
                                                  const begin = Offset(
                                                    1.0,
                                                    0.0,
                                                  );
                                                  const end = Offset.zero;
                                                  const curve =
                                                      Curves.easeInOut;
                                                  var tween = Tween(
                                                    begin: begin,
                                                    end: end,
                                                  ).chain(
                                                    CurveTween(curve: curve),
                                                  );
                                                  var offsetAnimation =
                                                      animation.drive(tween);
                                                  return SlideTransition(
                                                    position: offsetAnimation,
                                                    child: child,
                                                  );
                                                },
                                                transitionDuration:
                                                    const Duration(
                                                      milliseconds: 500,
                                                    ),
                                              ),
                                            );
                                          } catch (e) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text('Error: $e'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          } finally {
                                            pgFormProvider.setLoading(false);
                                          }
                                        }
                                      },
                              child:
                                  pgFormProvider.isLoading
                                      ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      )
                                      : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.check_circle),
                                          SizedBox(width: 8),
                                          Text(
                                            'Submit PG Property',
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
