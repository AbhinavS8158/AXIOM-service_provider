import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/property_type_.dropdown.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class DropdownFurnished extends StatelessWidget {
  final PropertycardFormModel? property;
  const DropdownFurnished({super.key, this.property});

  static const List<String> furnishedOptions = [
    'Unfurnished',
    'Semi furnished',
    'Fully furnished',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyTypeProvider>(
      builder: (context, provider, _) {
        String? selectValue;

        if (property?.furnished != null && property!.furnished.isNotEmpty) {
          if (furnishedOptions.contains(property!.furnished)) {
            selectValue = property!.furnished;
          }
        } else if (provider.furnished != null && provider.furnished!.isNotEmpty) {
          if (furnishedOptions.contains(provider.furnished)) {
            selectValue = provider.furnished;
          }
        }

        return DropdownButtonFormField<String>(
          value: selectValue,
          decoration: InputDecoration(
            hintText: 'Furnished',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Colors.grey[100],
          ),
          items: furnishedOptions.map((String value) {
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
