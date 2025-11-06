import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/sell_form_provider.dart';
import 'package:service_provider/model/properycard_form_model.dart';
import 'package:service_provider/view/screen/updateScreen/update_screen_sell.dart';

class SButtons extends StatelessWidget {
  final PropertycardFormModel property;
  const SButtons({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SellFormProvider>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UpdateSellForm(property: property,)),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          child: Text('update', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 30),
        ElevatedButton(
          onPressed: () async {
            if (property.id != null && property.id!.isNotEmpty) {
              final confirmDelete = await showDialog<bool>(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Confirm Deletion'),
                      content: const Text(
                        'Are you sure you want to delete this property?',
                      ),
                      actions: [
                        TextButton(
                          onPressed:
                              () => Navigator.pop(context, false), // Cancel
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed:
                              () => Navigator.pop(context, true), // Confirm
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    
              );
              // ignore: use_build_context_synchronously
              Navigator.pop(context);

              // If user confirmed, proceed with deletion
              if (confirmDelete == true) {
                await controller.deleteRentalDataById(property.id!);
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Property deleted successfully'),
                  ),
                );
              }
            } else {
              log('No document ID provided');
            
            }
          },

          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          child: Text('delete', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
