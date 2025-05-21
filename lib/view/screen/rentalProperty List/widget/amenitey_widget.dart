
import 'package:flutter/material.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class AmenitiesWidget extends StatelessWidget {
  final PropertycardFormModel property;
  const AmenitiesWidget({Key? key, required this.property}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Amenities',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: property.amenities.map((amenity) => 
            Chip(
              backgroundColor: Colors.blue[50],
              label: Text(amenity.values.toString()),
              avatar: const Icon(Icons.check_circle, color: Colors.blue, size: 16),
            )
          ).toList(),
        ),
      ],
    );
  }
}
