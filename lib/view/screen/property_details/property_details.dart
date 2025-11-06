import 'package:flutter/material.dart';
import 'package:service_provider/model/properycard_form_model.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/rentalProperty List/widget/about_property_widget.dart';
import 'package:service_provider/view/screen/rentalProperty List/widget/amenitey_widget.dart';
import 'package:service_provider/view/screen/rentalProperty List/widget/backup_widget.dart';
import 'package:service_provider/view/screen/rentalProperty List/widget/buttons.dart';
import 'package:service_provider/view/screen/rentalProperty List/widget/carousels_widget.dart';
import 'package:service_provider/view/screen/rentalProperty List/widget/contact_widget.dart';
import 'package:service_provider/view/screen/rentalProperty List/widget/location_widget.dart';
import 'package:service_provider/view/screen/rentalProperty List/widget/property_features_widget.dart';
import 'package:service_provider/view/screen/rentalProperty List/widget/property_header.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final PropertycardFormModel property;
  final Stream<PropertycardFormModel?> propertyStream;

  const PropertyDetailsScreen({
    super.key,
    required this.property,
    required this.propertyStream,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        title: const Text('Property Details'),
        backgroundColor: AppColor.bg,
      ),
      body: StreamBuilder<PropertycardFormModel?>(
        stream: propertyStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Use updated property if available, else fallback to initial property
          final selectedProperty = snapshot.data ?? property;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageCarouselWidget(property: selectedProperty),
                const SizedBox(height: 16),
                PropertyHeaderWidget(property: selectedProperty),
                const SizedBox(height: 16),
                LocationWidget(property: selectedProperty),
                const SizedBox(height: 24),
                PropertyFeaturesCard(property: selectedProperty),
                const SizedBox(height: 24),
                ContactInformationWidget(property: selectedProperty),
                const SizedBox(height: 24),
                AboutPropertyWidget(property: selectedProperty),
                const SizedBox(height: 24),
                BackupInformationWidget(property: selectedProperty),
                const SizedBox(height: 24),
                AmenitiesWidget(property: selectedProperty),
                const SizedBox(height: 24),
                RButtons(property: selectedProperty),
              ],
            ),
          );
        },
      ),
    );
  }
}
