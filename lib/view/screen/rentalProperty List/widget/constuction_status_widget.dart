import 'package:flutter/material.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class ConstuctionStatusWidget extends StatelessWidget {
  final PropertycardFormModel property;
  // ignore: use_super_parameters
  const ConstuctionStatusWidget ({Key? key, required this.property}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
 
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        const SizedBox(height: 12),
        Text(
          property.status ?? "",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}