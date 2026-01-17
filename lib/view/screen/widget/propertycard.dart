import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/rental_form_provider.dart';
import 'package:service_provider/model/propertycard_form_model.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/booking_details/booking%20details.dart';
import 'package:service_provider/view/screen/property_details/property_details.dart';
// Import your Booking Details screen here
// import 'package:service_provider/view/screen/booking_details/booking_details_screen.dart';

class PropertyCard extends StatelessWidget {
  final PropertycardFormModel property;
  

  const PropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final bool isBooked = property.bookingstatus == 'booked';

    // Determine status UI dynamically
    Color statusBg;
    Color statusTextColor;
    IconData statusIcon;
    String displayStatus;

    switch (property.status) {
      case '1': // Accepted
        statusBg = const Color(0xFF059669);
        statusTextColor = Colors.white;
        statusIcon = Icons.check_circle;
        displayStatus = 'Approved';
        break;
      case '2': // Rejected
        statusBg = const Color(0xFFDC2626);
        statusTextColor = Colors.white;
        statusIcon = Icons.cancel;
        displayStatus = 'Rejected';
        break;
      default: // Pending
        statusBg = const Color(0xFFF59E0B);
        statusTextColor = Colors.white;
        statusIcon = Icons.schedule;
        displayStatus = 'Pending';
    }

    return GestureDetector(
      onTap: () => _navigateToViewDetails(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageSection(),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFeaturePill(),
                      const SizedBox(height: 8),
                      Text(
                        property.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        property.propertyType,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 8),
                      _buildLocationRow(),
                      const SizedBox(height: 16),
                      
                      // ACTION AREA: Price and the Conditional Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildPriceSection(isBooked),
                          const SizedBox(width: 8),
                          // Separate Buttons based on status
                          isBooked 
                            ? _buildBookingDetailsButton(context) 
                            : _buildViewDetailsButton(context),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _buildStatusBanner(statusBg, statusTextColor, statusIcon, displayStatus),
          ],
        ),
      ),
    );
  }

  // --- NAVIGATION METHODS ---

  void _navigateToViewDetails(BuildContext context) {
    final provider = Provider.of<RentalFormProvider>(context, listen: false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PropertyDetailsScreen(
          property: property,
          propertyStream: provider.getPropertyStream(property.id!),
        ),
      ),
    );
  }

void _navigateToBookingDetails(
  BuildContext context,
  String propertyId,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => MyBookingsScreen(propertyId: propertyId),
    ),
  );
}



  // --- UI COMPONENTS ---

 Widget _buildImageSection() {
  final String imageUrl = property.photoPath.isNotEmpty
      ? property.photoPath.first
      : '';

  return Stack(
    children: [
      ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: SizedBox(
          height: 180,
          width: double.infinity,
          child: imageUrl.isEmpty
              ? _buildPlaceholder()
              : Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 180,
                  loadingBuilder: (context, child, loadingProgress) {
                    // Image loaded instantly → show image
                    if (loadingProgress == null) return child;

                    // Image taking time → show placeholder
                    return _buildPlaceholder();
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return _buildPlaceholder();
                  },
                ),
        ),
      ),

      // Gradient Overlay
      Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    ],
  );
}


Widget _buildPlaceholder() {
  return Container(
    height: 180,
    color: Colors.grey.shade200,
    alignment: Alignment.center,
    child: Image.asset(
      'assets/img/pictures.png',
      width: 80,
      height: 80,
      fit: BoxFit.contain,
    ),
  );
}


  Widget _buildLocationRow() {
    return Row(
      children: [
        Icon(Icons.location_on, size: 14, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            property.location,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSection(bool isBooked) {
    final color = isBooked ? Colors.green : Colors.blue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.currency_rupee, size: 16, color: color.shade700),
            Text(
              property.amount,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color.shade700),
            ),
          ],
        ),
        Text("/month", style: TextStyle(fontSize: 11, color: color.shade600)),
      ],
    );
  }

  // SEPARATE BUTTON 1: View Details
  Widget _buildViewDetailsButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _navigateToViewDetails(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.forgot,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      icon: const Icon(Icons.arrow_forward, size: 16),
      label: const Text("View Details", style: TextStyle(fontSize: 12)),
    );
  }

  // SEPARATE BUTTON 2: Booking Details
 Widget _buildBookingDetailsButton(BuildContext context) {
  return ElevatedButton.icon(
    onPressed: () => _navigateToBookingDetails(
      context,
      property.id!, // ✅ pass propertyId correctly
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.orange.shade800,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    icon: const Icon(Icons.receipt_long, size: 16),
    label: const Text("Booking Details", style: TextStyle(fontSize: 12)),
  );
}


  Widget _buildStatusBanner(Color bg, Color textCol, IconData icon, String label) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(15),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: textCol),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: textCol, fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturePill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Text(
        property.furnished,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green.shade700),
      ),
    );
  }
}