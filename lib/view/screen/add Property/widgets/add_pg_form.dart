import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/cloudinary/cloudinary.dart';
import 'package:service_provider/controller/provider/amenities_pg_provider.dart';
import 'package:service_provider/controller/provider/pg_form_provider.dart';
import 'package:service_provider/controller/provider/pg_location_provider.dart';
import 'package:service_provider/controller/provider/photo_picker_provider_pg.dart';
import 'package:service_provider/controller/provider/propety_type_pg.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/pgProperty%20List/pg_propert_list.dart';
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
import 'package:service_provider/view/screen/widget/section_header.dart';
import 'package:service_provider/view/screen/widget/textfield.dart';

class AddPgForm extends StatelessWidget {
  AddPgForm({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final pgFormProvider = Provider.of<PgFormProvider>(context);
    final propertyTypeProviderPg = Provider.of<DropdownPgProvider>(context);
    final locationProvider = Provider.of<PgLocationProvider>(context);
    final photoPickerProvider = Provider.of<PhotoPickerProviderPg>(context);
    final amenitiesSellProvider = Provider.of<AmenitiesPgProvider>(context);
    final selectedAmenities = amenitiesSellProvider.getSelectedAmenities();
    

    return Scaffold(
      backgroundColor: AppColor.bg,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          
          SizedBox.expand(
            child: Lottie.asset(
              'assets/animation/Animation - 1746427682309.json',
              fit: BoxFit.cover,
              repeat: true,
            ),
          ),
          
      
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
                              controller: pgFormProvider.nameController,
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
                            
                            FieldLabel(text: 'Location'),
                            CustomTextField(
                              controller: locationProvider.locationController,
                              hint: 'Tap to get Location',
                              icon: Icons.location_on,
                              readOnly: true,
                              onPressed: () async {
                                await locationProvider.fetchCurrentLocation(context);
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
                              controller: pgFormProvider.phonenumController,
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
                              controller: pgFormProvider.emailController,
                              hint: 'Email',
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
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
                              controller: pgFormProvider.aboutcontroller,
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
                              controller: pgFormProvider.amountcontroller,
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
                          onPressed: () async{
                            log(photoPickerProvider.images.toString());
                            if (_formKey.currentState!.validate()) {

                              List<String >imageUrls=[];
                              for(var image in photoPickerProvider.images){
                                String url =await CloudinaryService().uploadImage(image);
                                imageUrls.add(url);
                              }

                              pgFormProvider.setName(pgFormProvider.nameController.text);
                              pgFormProvider.setPropertyType(propertyTypeProviderPg.selectedPropertyType.toString());
                              pgFormProvider.setLocation(locationProvider.locationController.text);
                              pgFormProvider.setPhone(pgFormProvider.phonenumController.text);
                              pgFormProvider.setPhotoPath(imageUrls);
                              pgFormProvider.setEmail(pgFormProvider.emailController.text);
                              pgFormProvider.setAbout(pgFormProvider.aboutcontroller.text);
                              pgFormProvider.setFurnished(propertyTypeProviderPg.furnished.toString());
                              pgFormProvider.setPowerbackup(propertyTypeProviderPg.powerbackup.toString());
                              pgFormProvider.setAmount(pgFormProvider.amountcontroller.text);
                              pgFormProvider.setFood(propertyTypeProviderPg.food.toString());
                              pgFormProvider.setBathroom(propertyTypeProviderPg.bathroom.toString());
                              pgFormProvider.setBedroom(propertyTypeProviderPg.bedroom.toString());
                              pgFormProvider.setAmenities(selectedAmenities);

                              pgFormProvider.addtodb(context);

                              // Show success message before navigation
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: const [
                                      Icon(Icons.check_circle, color: Colors.white),
                                      SizedBox(width: 10),
                                      Text('PG property added successfully!'),
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
                                    pageBuilder: (context, animation, secondaryAnimation) => 
                                      const PgPropertList(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      const begin = Offset(1.0, 0.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOut;
                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                      var offsetAnimation = animation.drive(tween);
                                      return SlideTransition(position: offsetAnimation, child: child);
                                    },
                                    transitionDuration: const Duration(milliseconds: 500),
                                  ),
                                );
                            
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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