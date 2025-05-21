import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/property_type_.dropdown.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class DropdownPowerbackup extends StatelessWidget {
  final PropertycardFormModel? property;
  const DropdownPowerbackup({super.key, this.property});

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyTypeProvider>(
      builder: (context, provider, _) {
        final options = [
          'Full Backup',
          'Partial Backup',
          'Invetor Backup',
          'Generator Backup',
          'None'
        ];

        // Get selected value
        String? selectValue = property?.powerbackup?.isNotEmpty == true
            ? property!.powerbackup
            : provider.powerbackup;

        // Ensure value exists in the list
        if (selectValue != null && !options.contains(selectValue)) {
          selectValue = null;
        }

        return DropdownButtonFormField<String>(
          value: selectValue,
          decoration: InputDecoration(
            hintText: 'Powerbackup',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.grey[100],
          ),
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              provider.setPowerBackup(newValue);
            }
          },
        );
      },
    );
  }
}
