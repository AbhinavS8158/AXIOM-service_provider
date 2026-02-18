import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/rental_form_provider.dart';
import 'package:service_provider/model/propertycard_form_model.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/updateScreen/update_screen.dart';

class RButtons extends StatelessWidget {
  final PropertycardFormModel property;

  const RButtons({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RentalFormProvider>(context, listen: false);

    // Show update button only when status != '1' (works for int or String)
    // final bool showUpdate = property.status?.toString() != '1';
    final bool showUpdate =property.bookingstatus!= "booked";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showUpdate) ...[
          ElevatedButton(
            onPressed: () {
              log('update button clicked');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateRentalForm(property: property)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.forgot,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: const Text('update', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 30),
      ],

        ElevatedButton(
          onPressed: () async {
            if (property.id == null || property.id!.isEmpty) {
              log('No document ID provided');
              return;
            }

            final confirmDelete = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Confirm Deletion'),
                content: const Text('Are you sure you want to delete this property?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Delete', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );

            if (confirmDelete != true) return;

            try {
              await controller.deleteRentalDataById(property.id!);

              // show feedback
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Property deleted successfully')),
              );

              // close current screen (optional: return true to caller)
              Navigator.pop(context, true);
            } catch (e) {
              log('Delete error: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to delete property: $e')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.alert,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          child: const Text('delete', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
