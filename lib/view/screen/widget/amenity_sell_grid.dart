import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/amenity_sell_provider.dart';

class AmenitiesSellGrid extends StatelessWidget {
  const AmenitiesSellGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AmenitiesSellProvider>(context);
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
          final isSelected = amenity.isSelected;

          return GestureDetector(
            onTap: () => provider.toggleSelection(index),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.deepPurple : Colors.grey.shade400,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
                color: isSelected ? Colors.deepPurple.withOpacity(0.1) : Colors.white,
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
  }
}
