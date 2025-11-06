import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/amenity_rental_provider.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class AmenitiesGrid extends StatelessWidget {
  final PropertycardFormModel? property;
  const AmenitiesGrid({super.key, this.property});

  @override
  Widget build(BuildContext context) {
    return Consumer<AmenitiesProvider>(
      builder: (context, provider, _) {
        // Safe syncing inside the Consumer with condition
        if (property != null &&
            property!.amenities.isNotEmpty 
          ) {
          final names = property!.amenities
              .map((e) => e['name'].toString())
              .toList();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            provider.setSelectedFromProperty(names);
          });
        }

        final amenities = provider.amenities;

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: amenities.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.9,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final amenity = amenities[index];

              return GestureDetector(
                onTap: () => provider.toggleSelection(index),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: amenity.isSelected
                          ? Colors.deepPurple
                          : Colors.grey.shade400,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: amenity.isSelected
                        ? Colors.deepPurple.withOpacity(0.1)
                        : Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        amenity.icon,
                        size: 28,
                        color: Colors.deepPurple,
                      ),
                      const SizedBox(height: 6),
                      Flexible(
                        child: Text(
                          amenity.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
} 

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:service_provider/controller/provider/amenity_rental_provider.dart';
// import 'package:service_provider/model/properycard_form_model.dart';

// class AmenitiesGrid extends StatelessWidget {
//   const AmenitiesGrid({super.key, required PropertycardFormModel property});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<AmenitiesProvider>(context);
//     final amenities = provider.amenities;

//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: amenities.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           childAspectRatio: 0.9,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//         ),
//         itemBuilder: (context, index) {
//           final amenity = amenities[index];
//           final isSelected = amenity.isSelected;

//           return GestureDetector(
//             onTap: () => provider.toggleSelection(index),
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: isSelected ? Colors.deepPurple : Colors.grey.shade400,
//                   width: 1.5,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//                 color: isSelected ? Colors.deepPurple.withOpacity(0.1) : Colors.white,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     amenity.icon,
//                     size: 28,
//                     color: Colors.deepPurple,
//                   ),
//                   const SizedBox(height: 6),
//                   Flexible(
//                     child: Text(
//                       amenity.name,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(fontSize: 12),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
