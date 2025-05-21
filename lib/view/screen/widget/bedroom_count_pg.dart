import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/propety_type_pg.dart';


class BedroomCountPg extends StatelessWidget {
  const BedroomCountPg({super.key});


  @override
  Widget build(BuildContext context) {
    final propertyTypeProvider= Provider.of<DropdownPgProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Bed rooms',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Container(
                   
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all()
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
       IconButton(
         icon: Icon(Icons.arrow_drop_up),
         onPressed: propertyTypeProvider.increementbedroom,
         padding: EdgeInsets.zero,
         constraints: BoxConstraints(),
         iconSize: 24,
       ),
       Text(
         propertyTypeProvider.bedroom.toString(),
         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
       ),
       IconButton(
         icon: Icon(Icons.arrow_drop_down),
         onPressed: propertyTypeProvider.decrementBedrooms,
         padding: EdgeInsets.zero,
         constraints: BoxConstraints(),
         iconSize: 24,
       ),
                      ],
                    ),
                  ),
                ],
              ),
    );
               
  }
}