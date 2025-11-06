import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/pg_form_provider.dart';
import 'package:service_provider/model/properycard_form_model.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/rentalProperty%20List/widget/about_property_widget.dart';
import 'package:service_provider/view/screen/rentalProperty%20List/widget/amenitey_widget.dart';
import 'package:service_provider/view/screen/rentalProperty%20List/widget/backup_widget.dart';
import 'package:service_provider/view/screen/rentalProperty%20List/widget/button_pg.dart';
import 'package:service_provider/view/screen/rentalProperty%20List/widget/carousels_widget.dart';
import 'package:service_provider/view/screen/rentalProperty%20List/widget/contact_widget.dart';
import 'package:service_provider/view/screen/rentalProperty%20List/widget/food_widget.dart';
import 'package:service_provider/view/screen/rentalProperty%20List/widget/location_widget.dart';
import 'package:service_provider/view/screen/rentalProperty%20List/widget/property_features_widget.dart';
import 'package:service_provider/view/screen/rentalProperty%20List/widget/property_header.dart';

class PgPropertyDetailsScreen extends StatelessWidget {
  final PropertycardFormModel property;
   // ignore: use_super_parameters, prefer_const_constructors_in_immutables
   PgPropertyDetailsScreen({Key? key, required this.property}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final selectedproperty=property;
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        title: const Text('Property Details'),
        backgroundColor: AppColor.bg,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<PgFormProvider>(
          builder: (context, value, child) =>Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageCarouselWidget(property: selectedproperty,),
              const SizedBox(height: 16,),
              PropertyHeaderWidget(property: selectedproperty),
              const SizedBox(height: 16),
              FoodWidget(property: selectedproperty),
              SizedBox(height: 16,),
              LocationWidget(property: selectedproperty),
              const SizedBox(height: 24),
              PropertyFeaturesCard(property: selectedproperty),
              const SizedBox(height: 24),
              ContactInformationWidget(property: selectedproperty),
              const SizedBox(height: 24),
              AboutPropertyWidget(property: selectedproperty),
              const SizedBox(height: 24),
              BackupInformationWidget(property: selectedproperty),
              const SizedBox(height: 24),
              AmenitiesWidget(property: selectedproperty),
              const SizedBox(height: 24),
              PButtons(property: selectedproperty,),
            ],
          ),
        ),
      ),
    );
  }
}
