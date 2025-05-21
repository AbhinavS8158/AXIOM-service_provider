  import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/cloudinary/cloudinary.dart';
import 'package:service_provider/controller/provider/amenity_rental_provider.dart';
import 'package:service_provider/controller/provider/location_provider.dart';
import 'package:service_provider/controller/provider/photo_picker_provier.dart';
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
import 'package:service_provider/view/screen/widget/section_header.dart';
import 'package:service_provider/view/screen/widget/textfield.dart';


  class AddRentalForm extends StatelessWidget {
  
    const AddRentalForm({super.key,});

    @override
    Widget build(BuildContext context) {

      final _formKey = GlobalKey<FormState>();

      final locationProvider = Provider.of<LocationProvider>(context);
      final propertyTypeProvider = Provider.of<PropertyTypeProvider>(context);
      final photoPickerProvider = Provider.of<PhotoPickerProvider>(context);
      final amenitiesitems = Provider.of<AmenitiesProvider>(context);
      final rentalFromProvider = Provider.of<RentalFormProvider>(context);
      final selectedAmenities = amenitiesitems.getSelectedAmenities();
      WidgetsBinding.instance.addPostFrameCallback((_){
        locationProvider.locationController.clear();
        rentalFromProvider.nameController.clear();
        photoPickerProvider.images.clear();
        rentalFromProvider.emailController.clear();
        rentalFromProvider.phonenumController.clear();
        rentalFromProvider.aboutcontroller.clear();
        rentalFromProvider.amountcontroller.clear();
        amenitiesitems.clearSelectedAmenities();
        
      propertyTypeProvider.clearSelections();
      });

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

            // Form content with a frosted glass effect
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
                                
                                controller: rentalFromProvider.nameController,
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
                              const DropdownProperyType(),
                              const SizedBox(height: 16),

                              FieldLabel(text: 'Photos'),
                              const AddPhoto(),
                              const SizedBox(height: 16),

                              FieldLabel(text: 'Location'),
                              CustomTextField(
                                controller: locationProvider.locationController,
                                hint: 'Tap to get Location',
                                icon: Icons.location_on,
                                readOnly: true,
                                onPressed: () async {
                                  await locationProvider.fetchCurrentLocation();
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please fetch location';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              FieldLabel(text: 'Contact Information'),
                              CustomTextField(
                                controller: rentalFromProvider.phonenumController,
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
                                controller: rentalFromProvider.emailController,
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
                                controller: rentalFromProvider.aboutcontroller,
                                hint: 'About Property',
                                icon: Icons.description,
                                maxLines: 3,
                              ),
                              const SizedBox(height: 16),

                              FieldLabel(text: 'Rental Amount'),
                              CustomTextField(
                                controller: rentalFromProvider.amountcontroller,
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
                                  Expanded(child: BedroomCount()),
                                  SizedBox(width: 4),
                                  Expanded(child: BathroomCount()),
                                ],
                              ),
                              const SizedBox(height: 16),

                              FieldLabel(text: 'Furnishing Status'),
                              const DropdownFurnished(),
                              const SizedBox(height: 16),
                              FieldLabel(text: 'Power backup'),
                              const DropdownPowerbackup(),
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
                              AmenitiesGrid(),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Submit Button
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 30),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  List<String> imageUrls = [];
                                  for (var image in photoPickerProvider.images) {
                                    String url = await CloudinaryService()
                                        .uploadImage(image);
                                    imageUrls.add(url);
                                  }

                                  rentalFromProvider.setName(
                                    rentalFromProvider.nameController.text,
                                  );
                                  rentalFromProvider.setPropertyType(
                                    propertyTypeProvider.selectedPropertyType
                                        .toString(),
                                  );
                                  rentalFromProvider.setLocation(
                                    locationProvider.locationController.text,
                                  );
                                  rentalFromProvider.setPhone(
                                    rentalFromProvider.phonenumController.text,
                                  );
                                  rentalFromProvider.setPhotoPath(imageUrls);
                                  rentalFromProvider.setEmail(
                                    rentalFromProvider.emailController.text,
                                  );
                                  rentalFromProvider.setAbout(
                                    rentalFromProvider.aboutcontroller.text,
                                  );
                                  rentalFromProvider.setFurnished(
                                    propertyTypeProvider.furnished.toString(),
                                  );
                                  rentalFromProvider.setPowerbackup(
                                    propertyTypeProvider.powerbackup.toString(),
                                  );
                                  rentalFromProvider.setAmount(
                                    rentalFromProvider.amountcontroller.text,
                                  );
                                  rentalFromProvider.setAmenities(
                                    selectedAmenities
                                        .map((amenity) => {'name': amenity})
                                        .toList(),
                                  );
                                  rentalFromProvider.setBathroom(
                                    propertyTypeProvider.bathroom.toString(),
                                  );
                                  rentalFromProvider.setBedroom(
                                    propertyTypeProvider.bedroom.toString(),
                                  );

                                  rentalFromProvider.addtodb(context);

                                  rentalFromProvider.nameController.clear();
                                  rentalFromProvider.phonenumController.clear();
                                  rentalFromProvider.emailController.clear();
                                  rentalFromProvider.aboutcontroller.clear();
                                  rentalFromProvider.amountcontroller.clear();
                                  locationProvider.locationController.clear();
                                  propertyTypeProvider.clearSelections();
                                  photoPickerProvider.clearImages();
                                  amenitiesitems.clearSelectedAmenities();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: const [
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10),
                                          Text('Property added successfully!'),
                                        ],
                                      ),
                                      backgroundColor: Colors.green,
                                      duration: const Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                          ) => const RentPropertyListingScreen(),
                                      transitionsBuilder: (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                        child,
                                      ) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;
                                        var tween = Tween(
                                          begin: begin,
                                          end: end,
                                        ).chain(CurveTween(curve: curve));
                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                      transitionDuration: const Duration(
                                        milliseconds: 500,
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error uploading images: $e'),
                                      backgroundColor: Colors.red,
                                      duration: const Duration(seconds: 3),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.check_circle),
                                SizedBox(width: 8),
                                Text(
                                  'Submit Property',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
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
