import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/property_type_.dropdown.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class DropdownProperyType extends StatelessWidget {
  final PropertycardFormModel? property;

  const DropdownProperyType({super.key, this.property});

  @override
  Widget build(BuildContext context) {
    final propertyTypeProvider = Provider.of<PropertyTypeProvider>(context);

    // Determine what to show initially
    final selectedValue = (property?.propertyType != null &&
            property!.propertyType.isNotEmpty)
        ? property!.propertyType
        : (propertyTypeProvider.selectedPropertyType?.isNotEmpty ?? false)
            ? propertyTypeProvider.selectedPropertyType
            : null;

    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        hintText: 'Property type',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      items: [
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
          propertyTypeProvider.setPropertyType(newValue);
        }
      },
    );
  }
}
