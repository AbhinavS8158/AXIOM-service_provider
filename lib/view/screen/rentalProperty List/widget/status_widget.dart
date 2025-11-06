

import 'package:flutter/material.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class StatusWidget extends StatelessWidget {
  final PropertycardFormModel property;
  // ignore: use_super_parameters
  const StatusWidget({Key? key, required this.property}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final selectedproperty=property;
    
    
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.blue, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            selectedproperty.status.toString(),
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