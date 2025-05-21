
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/property_type_provider_sell.dart';

class DropdownPropertyTypeSell extends StatelessWidget {
  const DropdownPropertyTypeSell({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyTypeProviderSell>(
      builder: (context, provider, _) {
        return DropdownButtonFormField<String>(
          value: provider.selectedPropertyType?.isEmpty ?? true ? null : provider.selectedPropertyType,
          decoration: InputDecoration(
            hintText:  'Propery type',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8 )
            ),
            filled: true,
            fillColor: Colors.grey[100],
          
          ),
          items:
              [
                'Apartment',
                'Independent House',
                'Villa',
                'Penthouse',
                'Duplex',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              provider.setPropertyType(newValue);
            }
          },
        );
      },
    );
  }
}