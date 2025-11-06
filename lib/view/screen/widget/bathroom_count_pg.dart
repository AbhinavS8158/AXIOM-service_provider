import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/property_type_pg.dart';

class BathroomCountPg extends StatelessWidget {
  const BathroomCountPg({super.key});

  @override
  Widget build(BuildContext context) {
    final propertyTypeProvider = Provider.of<DropdownPgProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Bath rooms',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_drop_up),
                  onPressed: propertyTypeProvider.increementbathroom,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  iconSize: 24,
                ),
                Text(
                  propertyTypeProvider.bathroom.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: propertyTypeProvider.decreementbathroom,
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
