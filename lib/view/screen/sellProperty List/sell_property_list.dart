// lib/view/screens/rent_property_listing_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/sell_property_provider.dart';
import 'package:service_provider/model/properycard_form_model.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/widget/propertycard.dart';

class SellPropertyList extends StatelessWidget {
  const SellPropertyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SellPropertyProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        backgroundColor: AppColor.bg,
        elevation: 0,
        title: const Text(
          'For Sell',
          style: TextStyle(
            color: Color(0xFFE0A76A),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: StreamBuilder<List<PropertycardFormModel>>(
        stream: provider.propertiesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          final properties = snapshot.data ?? [];

          return ListView.builder(
            itemCount: properties.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: PropertyCard(property: properties[index]),
              );
            },
          );
        },
      ),
    );
  }
}
