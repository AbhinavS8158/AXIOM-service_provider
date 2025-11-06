// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:service_provider/controller/provider/property_type_.dropdown.dart';
// import 'package:service_provider/model/properycard_form_model.dart';

// class BathroomCount extends StatelessWidget {
//   final PropertycardFormModel ?property;
//   const BathroomCount({super.key,  this.property});

//   @override
//   Widget build(BuildContext context) {
//     final propertyTypeProvider = Provider.of<PropertyTypeProvider>(context);
    
//     final dynamic bathroomCount = (property?.bathroom!= null && property!.bathroom.isNotEmpty)
//         ? property!.bathroom
//         : propertyTypeProvider.bathroom;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 2),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Bath rooms',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(width: 5),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 12),
//             decoration: BoxDecoration(
//               border: Border.all(),
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.arrow_drop_up),
//                   onPressed: propertyTypeProvider.increementbathroom,
//                   padding: EdgeInsets.zero,
//                   constraints: BoxConstraints(),
//                   iconSize: 24,
//                 ),
//                 Text(
//                   bathroomCount.toString(),
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.arrow_drop_down),
//                   onPressed: propertyTypeProvider.decreementbathroom,
//                   padding: EdgeInsets.zero,
//                   constraints: BoxConstraints(),
//                   iconSize: 24,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/property_type_.dropdown.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class BathroomCount extends StatelessWidget {
  final PropertycardFormModel? property;
  const BathroomCount({super.key,this.property});

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyTypeProvider>(
      builder: (context, provider, _) {
        final int bathroomCount = provider.bathroom;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Bathrooms',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_up),
                      onPressed: provider.increementbathroom,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      iconSize: 24,
                    ),
                    Text(
                      bathroomCount.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: provider.decreementbathroom,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      iconSize: 24,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
