import 'package:flutter/material.dart';
import 'package:service_provider/model/properycard_form_model.dart';
import 'package:service_provider/view/screen/property_details/property_details.dart';



class PropertyCard extends StatelessWidget {
  final PropertycardFormModel property;
  

  const PropertyCard({Key? key, required this.property}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
   final selectedproperty=property;
    
    return GestureDetector(
     onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PropertyDetailsScreen(property: selectedproperty,),
    ),
  );
},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                selectedproperty.photoPath.isNotEmpty
                    ? property.photoPath[0]
                    : 'https://via.placeholder.com/150',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
                border: Border.all(color: Colors.blue.shade100, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildFeaturePill(selectedproperty),
                      const SizedBox(width: 8),
                     
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    selectedproperty.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "₹ ${selectedproperty.amount} /month",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    selectedproperty.propertyType,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  Row(
                    children: [
                      Text(
                        selectedproperty.location,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.location_on, size: 16),
                      label: const Text('See on Map'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE0A76A),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturePill(PropertycardFormModel property) {
    final selectedproperty=property;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, size: 12, color: Colors.blue.shade700),
          const SizedBox(width: 4),
          Text(
            selectedproperty.furnished,
            style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
          ),
        ],
      ),
    );
  }
}
