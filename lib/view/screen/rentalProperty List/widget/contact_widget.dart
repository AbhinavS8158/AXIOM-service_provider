
import 'package:flutter/material.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class ContactInformationWidget extends StatelessWidget {
  final PropertycardFormModel property;
  const ContactInformationWidget({Key? key, required this.property}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.phone, size: 20, color: Colors.blue),
            const SizedBox(width: 8),
            Text(
              property.phoneNumber ,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.email, size: 20, color: Colors.blue),
            const SizedBox(width: 8),
            Text(
              property.email,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
