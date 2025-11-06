

import 'package:flutter/material.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class LocationWidget extends StatelessWidget {
  final PropertycardFormModel property;
  // ignore: use_super_parameters
  const LocationWidget({Key? key, required this.property}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    
    return Row(
      children: [
        const Icon(Icons.location_on, color: Colors.red, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            property.location,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }
}