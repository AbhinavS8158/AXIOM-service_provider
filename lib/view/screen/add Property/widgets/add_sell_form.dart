// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/cloudinary/cloudinary.dart';
import 'package:service_provider/controller/provider/amenity_sell_provider.dart';
import 'package:service_provider/controller/provider/location_provider.dart';
import 'package:service_provider/controller/provider/photo_picker_provider_sell.dart';
import 'package:service_provider/controller/provider/property_type_provider_sell.dart';
import 'package:service_provider/controller/provider/sell_form_provider.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/sellProperty%20List/sell_property_list.dart';
import 'package:service_provider/view/screen/widget/add_photo_sell.dart';
import 'package:service_provider/view/screen/widget/amenity_sell_grid.dart';
import 'package:service_provider/view/screen/widget/bathroom_count_sell.dart';
import 'package:service_provider/view/screen/widget/bedroom_count_sell.dart';
import 'package:service_provider/view/screen/widget/construction_status.dart';
import 'package:service_provider/view/screen/widget/custom_card.dart';
import 'package:service_provider/view/screen/widget/dropdown_furnisher_sell.dart';
import 'package:service_provider/view/screen/widget/dropdown_powerbackup_sell.dart';
import 'package:service_provider/view/screen/widget/dropdown_property_type_sell.dart';
import 'package:service_provider/view/screen/widget/field_label.dart';
import 'package:service_provider/view/screen/widget/location_input_widget.dart';
import 'package:service_provider/view/screen/widget/section_header.dart';
import 'package:service_provider/view/screen/widget/textfield.dart';

class AddSellForm extends StatelessWidget {
  const AddSellForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColor.bg,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 🌀 Animated background
          SizedBox.expand(
            child: Lottie.asset(
              'assets/animation/Animation - 1746427682309.json',
              fit: BoxFit.cover,
              repeat: true,
            ),
          ),

          // 🧾 Form content
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

                      // 🏠 Basic Details
                      SectionHeader(
                        title: 'Basic Details',
                        icon: Icons.villa_outlined,
                      ),
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FieldLabel(text: 'Name of the building'),
                            CustomTextField(
                              controller: context.read<SellFormProvider>().nameController,
                              hint: "Name of the building",
                              icon: Icons.domain,
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please enter building name'
                                      : null,
                            ),
                            const SizedBox(height: 16),
                            FieldLabel(text: 'Property type'),
                            const DropdownPropertyTypeSell(),
                            const SizedBox(height: 16),
                            const AddPhotoSell(),
                            const SizedBox(height: 16),
                            FieldLabel(text: 'Construction status'),
                            const ConstructionStatus(),
                            const SizedBox(height: 16),
                            const FieldLabel(text: 'Location'),
                            const LocationInputWidget(),
                            const SizedBox(height: 16),
                            FieldLabel(text: 'Contact Information'),
                            CustomTextField(
                              controller: context.read<SellFormProvider>().phonenumController,
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
                              controller: context.read<SellFormProvider>().emailController,
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

                      // ⚙️ Advanced Details
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
                              controller: context.read<SellFormProvider>().aboutController,
                              hint: 'About Property',
                              icon: Icons.description,
                              maxLines: 3,
                            ),
                            const SizedBox(height: 16),
                            FieldLabel(text: 'Selling Price'),
                            CustomTextField(
                              controller: context.read<SellFormProvider>().amountController,
                              hint: 'Price (₹)',
                              icon: Icons.currency_rupee,
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please enter the selling price'
                                      : null,
                            ),
                            const SizedBox(height: 16),
                            FieldLabel(text: 'Room Configuration'),
                            Row(
                              children: const [
                                Expanded(child: BedroomCountSell()),
                                SizedBox(width: 4),
                                Expanded(child: BathroomCountSell()),
                              ],
                            ),
                            const SizedBox(height: 16),
                            FieldLabel(text: 'Furnishing Status'),
                            const DropdownFurnisherSell(),
                            const SizedBox(height: 16),
                            FieldLabel(text: 'Power Backup'),
                            const DropdownPowerbackupSell(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // 🌟 Amenities
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
                            AmenitiesSellGrid(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // 🚀 Submit Button
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Consumer<SellFormProvider>(
                          builder: (context, sellFormProvider, _) {
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
                              onPressed: sellFormProvider.isLoading
                                  ? null
                                  : () async {
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
                                        sellFormProvider.setLoading(true);

                                        final propertyTypeProviderSell = context.read<PropertyTypeProviderSell>();
                                        final locationProvider = context.read<LocationProvider>();
                                        final photoPickerProvider = context.read<PhotoPickerProviderSell>();
                                        final amenitiesProviderSell = context.read<AmenitiesSellProvider>();

                                        // ✅ Validation checks
                                        if (propertyTypeProviderSell.bedroom <= 0 ||
                                            propertyTypeProviderSell.bathroom <= 0) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Please select at least one bedroom and bathroom"),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          return;
                                        }

                                        if (photoPickerProvider.images.isEmpty) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Please upload at least one property photo."),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          return;
                                        }

                                        if (locationProvider.locationController.text.isEmpty) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Please enter the property location."),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          return;
                                        }

                                        // ✅ Upload images
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

                                        // ✅ Save form data
                                        sellFormProvider
                                          ..setName(sellFormProvider.nameController.text)
                                          ..setPropertyType(propertyTypeProviderSell.selectedPropertyType ?? '')
                                          ..setLocation(locationProvider.locationController.text)
                                          ..setPhone(sellFormProvider.phonenumController.text)
                                          ..setEmail(sellFormProvider.emailController.text)
                                          ..setAbout(sellFormProvider.aboutController.text)
                                          ..setAmount(sellFormProvider.amountController.text)
                                          ..setFurnished(propertyTypeProviderSell.furnished ?? '')
                                          ..setPowerbackup(propertyTypeProviderSell.powerbackup ?? '')
                                          ..setConstructionStatus(propertyTypeProviderSell.constructionstatus ?? '')
                                          ..setPhotoPath(imageUrls)
                                          ..setAmenities(
                                            amenitiesProviderSell
                                                .getSelectedAmenities()
                                                .map((e) => {'name': e})
                                                .toList(),
                                          )
                                          ..setBedroom(propertyTypeProviderSell.bedroom.toString())
                                          ..setBathroom(propertyTypeProviderSell.bathroom.toString());

                                        // ✅ Save to Firestore
                                        await sellFormProvider.addToDb(context);

                                        // ✅ Reset after success
                                        sellFormProvider.resetForm();
                                        photoPickerProvider.clearImages();
                                        propertyTypeProviderSell.resetSelections();
                                        locationProvider.resetLocation();
                                        amenitiesProviderSell.clearSelectedAmenities();

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Row(
                                              children: const [
                                                Icon(Icons.check_circle, color: Colors.white),
                                                SizedBox(width: 10),
                                                Text('Property listed successfully!'),
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

                                        // ✅ Navigate to sell list
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const SellPropertyList(),
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
                                        sellFormProvider.setLoading(false);
                                      }
                                    },
                              child: sellFormProvider.isLoading
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
                                          'List Property For Sale',
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
