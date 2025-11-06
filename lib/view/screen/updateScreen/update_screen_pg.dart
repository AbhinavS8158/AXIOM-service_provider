import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/cloudinary/cloudinary.dart';
import 'package:service_provider/controller/provider/amenity_rental_provider.dart';
import 'package:service_provider/controller/provider/location_provider.dart';
import 'package:service_provider/controller/provider/pg_form_provider.dart';
import 'package:service_provider/controller/provider/photo_picker_provider.dart';
import 'package:service_provider/controller/provider/property_type_.dropdown.dart';
import 'package:service_provider/model/properycard_form_model.dart';
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

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(
      context,
      listen: false,
    );
    final propertyTypeProvider = Provider.of<PropertyTypeProvider>(
      context,
      listen: false,
    );
    final photoPickerProvider = Provider.of<PhotoPickerProvider>(
      context,
      listen: false,
    );
    final amenitiesProvider = Provider.of<AmenitiesProvider>(
      context,
      listen: false,
    );
    final pgFormProvider = Provider.of<PgFormProvider>(
      context,
      listen: false,
    );


    pgFormProvider.nameController.text = property.name;
    pgFormProvider.phonenumController.text = property.phoneNumber;
    pgFormProvider.emailController.text = property.email;
    pgFormProvider.aboutcontroller.text = property.about;
    pgFormProvider.amountcontroller.text = property.amount.toString();
    locationProvider.locationController.text = property.location;

    // final properytype = propertyTypeProvider.selectedPropertyType.toString();

    final formKey = pgFormProvider.formKey;

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
                        controller: pgFormProvider.nameController,
                        hint: 'Name of the building',
                        icon: Icons.domain,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Please enter building name'
                                    : null,
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
                        controller: pgFormProvider.phonenumController,
                        hint: 'Phone number',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Please enter your phone number'
                                    : !RegExp(r'^\d{10}$').hasMatch(value)
                                    ? 'Enter valid 10-digit number'
                                    : null,
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: pgFormProvider.emailController,
                        hint: 'Email',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Please enter your email'
                                    : !RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                    ).hasMatch(value)
                                    ? 'Enter valid email'
                                    : null,
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
                        controller: pgFormProvider.aboutcontroller,
                        hint: 'About Property',
                        icon: Icons.description,
                        maxLines: 3,
                      ),
                      FieldLabel(text: 'Food Availability'),
                            DropdownFoodPg(property:property),
                            const SizedBox(height: 16),
                      const SizedBox(height: 16),
                      FieldLabel(text: 'Rental Amount'),
                      CustomTextField(
                        controller: pgFormProvider.amountcontroller,
                        hint: 'Amount (₹)',
                        icon: Icons.currency_rupee,
                        keyboardType: TextInputType.number,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Enter amount'
                                    : null,
                      ),
                      const SizedBox(height: 16),
                      FieldLabel(text: 'Room Configuration'),
                      Row(
                        children: [
                          Expanded(child: BedroomCount(property: property)),
                          SizedBox(width: 4),
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

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {

                          List<String> imageUrls = [];
                     
                          if (photoPickerProvider.images.isEmpty) {
                            imageUrls = property.photoPath;
                          } else {
                            for (var image in photoPickerProvider.images) {
                              String url = await CloudinaryService()
                                  .uploadImage(image);
                                  
                              imageUrls.add(url);
                            }
                          }

          

                          pgFormProvider.setName(
                            pgFormProvider.nameController.text,
                          );
                          pgFormProvider.setPropertyType(
                            propertyTypeProvider.selectedPropertyType
                                    ?.toString() ??
                                property.propertyType,
                          );

                          pgFormProvider.setLocation(
                            locationProvider.locationController.text,
                          );
                          pgFormProvider.setPhone(
                            pgFormProvider.phonenumController.text,
                          );
                          pgFormProvider.setPhotoPath(imageUrls);
                          pgFormProvider.setEmail(
                            pgFormProvider.emailController.text,
                          );
                          pgFormProvider.setAbout(
                            pgFormProvider.aboutcontroller.text,
                          );
                          pgFormProvider.setFurnished(
                            propertyTypeProvider.furnished?.toString() ??
                                property.furnished,
                          );

                          pgFormProvider.setPowerbackup(
                            propertyTypeProvider.powerbackup?.toString() ??
                                property.powerbackup,
                          );

                          pgFormProvider.setAmount(
                            pgFormProvider.amountcontroller.text,
                          );
                          pgFormProvider.setAmenities(
                            amenitiesProvider
                                .getSelectedAmenities()
                                .map((e) => {'name': e})
                                .toList(),
                          );
                          pgFormProvider.setBathroom(
                            propertyTypeProvider?.bathroom.toString() ??
                                property.bathroom,
                          );

                          pgFormProvider.setBedroom(
                            propertyTypeProvider.bedroom?.toString() ??
                                property.bedroom,
                          );
                          await pgFormProvider.update(property.id!);

                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Property updated successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );

                          // ignore: use_build_context_synchronously
                          Navigator.pop(context,property);
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
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
