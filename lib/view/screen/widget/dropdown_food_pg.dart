import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/property_type_pg.dart';
import 'package:service_provider/model/properycard_form_model.dart';


class DropdownFoodPg extends StatelessWidget {
  final List<String> foodOptions = ['Available', 'Not Available'];

   DropdownFoodPg({super.key, PropertycardFormModel ?property});


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DropdownPgProvider>(context);
      final currentFood=provider.food;
        final isValidValue = foodOptions.contains(currentFood);

    return DropdownButtonFormField<String>(
      value: isValidValue?currentFood:null,
      decoration: InputDecoration(
        border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(8)
        ),
        prefixIcon: Icon(Icons.fastfood),
      
      ),
      items: foodOptions.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          provider.setFood(newValue);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select food availability';
        }
        return null;
      },
    );
  }
}
