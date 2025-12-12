import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/sell_form_provider.dart';
import 'package:service_provider/model/propertycard_form_model.dart';
import 'package:service_provider/view/screen/updateScreen/update_screen_sell.dart';

class SButtons extends StatelessWidget {
  final PropertycardFormModel property;

  const SButtons({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SellFormProvider>(context, listen: false);
    final bool isEditable=property.status?.toString() !='1';

     return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isEditable) ...[
          ElevatedButton(
            onPressed: () {
              log('update button clicked');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateSellForm(property: property)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
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
              await controller.deleteSellPropertyById(property.id!);

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
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          child: const Text('delete', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}