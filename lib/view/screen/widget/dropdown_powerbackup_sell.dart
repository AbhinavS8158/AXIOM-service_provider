import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/property_type_provider_sell.dart';

class DropdownPowerbackupSell extends StatelessWidget {
  const DropdownPowerbackupSell({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyTypeProviderSell>(
      builder: (context, provider, _) {
        return DropdownButtonFormField<String>(
          value:
              provider.powerbackup?.isEmpty ?? true
                  ? null
                  : provider.powerbackup,
          decoration: InputDecoration(
            hintText: 'Powerbackup',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Colors.grey[100],
          ),
          items:
              [
                'Full Backup',
                'Partial Backup',
                'Invetor Backup',
                'Generator Backup',
                'None',
              ].map((String value) {
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
