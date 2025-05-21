
import 'package:flutter/material.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class PropertyHeaderWidget extends StatelessWidget {
  final PropertycardFormModel property;
  const PropertyHeaderWidget({Key? key, required this.property}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                property.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                property.propertyType,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Text(
          '\$${property.amount}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}