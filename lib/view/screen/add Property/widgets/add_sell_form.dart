import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/cloudinary/cloudinary.dart';
import 'package:service_provider/controller/provider/amenity_sell_provider.dart';
import 'package:service_provider/controller/provider/photo_picker_provider_sell.dart';
import 'package:service_provider/controller/provider/property_type_provider_sell.dart';
import 'package:service_provider/controller/provider/sell_form_provider.dart';
import 'package:service_provider/controller/provider/sell_location_provider.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/home%20Screen/home_screen.dart';
import 'package:service_provider/view/screen/widget/add_photo_sell.dart';
import 'package:service_provider/view/screen/widget/amenity_sell_grid.dart';
import 'package:service_provider/view/screen/widget/bathroom_count_sell.dart';
import 'package:service_provider/view/screen/widget/bedroom_count_sell.dart';
import 'package:service_provider/view/screen/widget/construction_status.dart';
import 'package:service_provider/view/screen/widget/dropdown_furnisher_sell.dart';
import 'package:service_provider/view/screen/widget/dropdown_powerbackup_sell.dart';
import 'package:service_provider/view/screen/widget/dropdown_property_type_sell.dart';
import 'package:service_provider/view/screen/widget/textfield.dart';


class AddSellForm extends StatelessWidget {
  AddSellForm({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final sellFormProvider = Provider.of<SellFormProvider>(context);
    final propertyTypeProviderSell = Provider.of<PropertyTypeProviderSell>(context);
    final locationProvider = Provider.of<SellLocationProvider>(context);
    final photoPickerProvider = Provider.of<PhotoPickerProviderSell>(context);
    final amenitiesSellProvider = Provider.of<AmenitiesSellProvider>(context);
    final selectedAmenities = amenitiesSellProvider.getSelectedAmenities();
    // final photoPaths = photoPickerProvider.images.map((file) => file.path).toList();

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
                      _buildSectionHeader(
                        title: 'Basic Details',
                        icon: Icons.villa_outlined,
                      ),
                      
                      _buildCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Name of the building'),
                            CustomTextField(
                              controller: sellFormProvider.nameController,
                              hint: "Name of the building",
                              icon: Icons.domain,
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Please enter building name'
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            
                            _buildLabel('Property type'),
                            const DropdownPropertyTypeSell(),
                            const SizedBox(height: 16),
                            
                            _buildLabel('Photos'),
                            const AddPhotoSell(),
                            const SizedBox(height: 16),
                            
                            _buildLabel('Construction status'),
                            const ConstructionStatus(),
                            const SizedBox(height: 16),
                            
                            _buildLabel('Location'),
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
                            
                            _buildLabel('Contact Information'),
                            CustomTextField(
                              controller: sellFormProvider.phonenumController,
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
                              controller: sellFormProvider.emailController,
                              hint: 'Email',
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
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
                      _buildSectionHeader(
                        title: 'Advanced Details',
                        icon: Icons.settings_outlined,
                      ),
                      
                      _buildCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('About Property'),
                            CustomTextField(
                              controller: sellFormProvider.aboutcontroller,
                              hint: 'About Property',
                              icon: Icons.description,
                              maxLines: 3,
                            ),
                            const SizedBox(height: 16),
                            
                            _buildLabel('Selling Price'),
                            CustomTextField(
                              controller: sellFormProvider.amountcontroller,
                              hint: 'Price (₹)',
                              icon: Icons.currency_rupee,
                              keyboardType: TextInputType.number,
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Please enter the selling price'
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            
                            _buildLabel('Room Configuration'),
                            Row(
                              children: const [
                                Expanded(
                                  child: BedroomCountSell(),
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: BathroomCountSell(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            
                            _buildLabel('Furnishing Status'),
                            const DropdownFurnisherSell(),
                            const SizedBox(height: 16),
                            
                            _buildLabel('Power Backup'),
                            const DropdownPowerbackupSell(),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Amenities Section
                      _buildSectionHeader(
                        title: 'Amenities',
                        icon: Icons.star_border_outlined,
                      ),
                      
                      _buildCard(
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
                            AmenitiesSellGrid(),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Submit button with gradient
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 30),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.deepPurple, Colors.indigo],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.withOpacity(0.4),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: ()async {
                              if (_formKey.currentState!.validate()) {
                                // Process form data
                                
                              
                                List<String> imageUrls = [];
                                for (var image in photoPickerProvider.images) {
                                  String url = await CloudinaryService().uploadImage(image);
                                  imageUrls.add(url);
                                }
                                sellFormProvider.setName(sellFormProvider.nameController.text);
                                sellFormProvider.setPropertyType(propertyTypeProviderSell.selectedPropertyType.toString());
                                sellFormProvider.setLocation(locationProvider.locationController.text);
                                sellFormProvider.setPhone(sellFormProvider.phonenumController.text);
                                sellFormProvider.setPhotoPath(imageUrls);
                                sellFormProvider.setEmail(sellFormProvider.emailController.text);
                                sellFormProvider.setAbout(sellFormProvider.aboutcontroller.text);
                                sellFormProvider.setFurnished(propertyTypeProviderSell.furnished.toString());
                                sellFormProvider.setPowerbackup(propertyTypeProviderSell.powerbackup.toString());
                                sellFormProvider.setAmount(sellFormProvider.amountcontroller.text);
                                sellFormProvider.setAmenities(selectedAmenities);
                                sellFormProvider.setStatus(propertyTypeProviderSell.status.toString());

                                sellFormProvider.addtodb(context);
                                
                                // Show success message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: const [
                                        Icon(Icons.check_circle, color: Colors.white),
                                        SizedBox(width: 10),
                                        Text('Property listed for sale successfully!'),
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

                                // Navigate with animation
                                Future.delayed(const Duration(seconds: 1), () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => 
                                        const HomeScreen(),
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
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.real_estate_agent),
                                SizedBox(width: 8),
                                Text(
                                  'List Property For Sale',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
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

  // Helper method to create section headers
  Widget _buildSectionHeader({required String title, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.deepPurple,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.deepPurple.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create a card with frosted glass effect
  Widget _buildCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }

  // Helper method to create form field labels
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}