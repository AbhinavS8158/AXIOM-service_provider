
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/property_type_provider_sell.dart';

class ConstructionStatus extends StatelessWidget {
  const ConstructionStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyTypeProviderSell>(
      builder: (context, provider, _) {
        return DropdownButtonFormField<String>(
          value: provider.status?.isEmpty ?? true ? null : provider.status,
          decoration: InputDecoration(
            hintText:  'Construction Status',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8 )
            ),
            filled: true,
            fillColor: Colors.grey[100]
          ),
          items:
              [
               'Under Construction ',
               'Partially Completed ',
               'Completed'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              provider.setStatus(newValue);
            }
          },
        );
      },
    );
  }
}