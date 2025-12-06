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

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateSellForm(property: property),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          child: const Text('update', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 30),
        ElevatedButton(
          onPressed: () async {
            if (property.id == null || property.id!.isEmpty) {
              log('No document ID');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Delete failed: no document ID')),
              );
              return;
            }

            final confirm = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Confirm Delete'),
                content: const Text('Do you want to delete this property?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );

            if (confirm != true) return; // User cancelled ❌

            await controller.deleteSellPropertyById(property.id!);

            if (!context.mounted) return;

            Navigator.pop(context); // Close details page after delete

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Property deleted successfully'),
              ),
            );
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
