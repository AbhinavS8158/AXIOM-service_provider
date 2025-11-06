

import 'package:flutter/material.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class PropertyFeaturesCard extends StatelessWidget {
  final PropertycardFormModel property;
  // ignore: use_super_parameters
  const PropertyFeaturesCard({Key? key, required this.property, }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
   
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInfoColumn(Icons.bedroom_parent, property.bedroom, 'Bedrooms'),
            _buildInfoColumn(Icons.bathroom, property.bathroom, 'Bathrooms'),
            _buildInfoColumn(Icons.chair, property.furnished, 'Furnished'),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoColumn(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

}