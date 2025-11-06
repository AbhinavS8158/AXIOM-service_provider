
import 'package:flutter/material.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class AboutPropertyWidget extends StatelessWidget {
  final PropertycardFormModel property;
  // ignore: use_super_parameters
  const AboutPropertyWidget({Key? key, required this.property}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About Property',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          property.about ,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[800],
            height: 1.5,
          ),
        ),
      ],
    );
  }
}