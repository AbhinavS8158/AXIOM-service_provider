import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/amenities_pg_provider.dart';

class AmenitiesPgGrid extends StatelessWidget {
  const AmenitiesPgGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AmenitiesPgProvider>(context);
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
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final amenity = amenities[index];
          return GestureDetector(
            onTap: () => provider.toggleSelection(index),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: amenity.isSelected ? Colors.deepPurple : Colors.grey.shade400,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
                color: amenity.isSelected ? Colors.deepPurple.withOpacity(0.1) : Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(amenity.icon, size: 32, color: Colors.deepPurple),
                  const SizedBox(height: 6),
                  Text(
                    amenity.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
