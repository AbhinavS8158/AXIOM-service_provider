
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/property_type_provider_sell.dart';

class DropdownFurnisherSell extends StatelessWidget {
  const DropdownFurnisherSell({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyTypeProviderSell>(
      builder: (context, provider, _) {
        return DropdownButtonFormField<String>(
          value: provider.furnished?.isEmpty ?? true ? null : provider.furnished,
          decoration: InputDecoration(
            hintText:  'Furnished',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8 )
            ),
            filled: true,
            fillColor: Colors.grey[100]
          ),
          items:
              [
               'Unfurnished',
               'Semi furnished',
               'Fully furnished'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              provider.setFurnished(newValue);
            }
          },
        );
      },
    );
  }
}