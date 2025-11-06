

import 'package:flutter/material.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class FoodWidget extends StatelessWidget {
  final PropertycardFormModel property;
  // ignore: use_super_parameters
  const FoodWidget({Key? key, required this.property}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final String foodStatus=  property.food?.toString().toLowerCase()?? '';
    final bool isAvailable = foodStatus == 'available';
    
    return Row(
      children: [
        const Icon(Icons.restaurant, color: Colors.blue, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            property.food.toString(),
            style: TextStyle(
              fontSize: 16,
             color: isAvailable ? Colors.green : Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}