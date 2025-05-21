// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:service_provider/controller/dropdown_property_type.dart';

// class ConstructionStatus extends StatelessWidget {
//   const ConstructionStatus({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Consumer<PropertyTypeProvider>(
//                       builder: (context, provider, _) {
//                         return DropdownButtonFormField<String>(
//                           value: provider.selectedPropertyType,
//                           decoration: InputDecoration(
//                             hintText:  'Construction Status',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8 )
//                             ),
//                             filled: true,
//                             fillColor: Colors.grey[100]
//                           ),
//                           items:
//                               [
//                                 'Ready to move',
//                                 'Under construction',
//                                 'New launched',
                               
//                               ].map((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                           onChanged: (String? newValue) {
//                             if (newValue != null) {
//                               provider.setPropertyType(newValue);
//                             }
//                           },
//                         );
//                       },
//                     ),
//                   );
//   }
// }