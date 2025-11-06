import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/location_provider.dart';
import 'package:service_provider/view/screen/widget/textfield.dart';

class LocationInputWidget extends StatelessWidget {
  const LocationInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle buttons for location mode
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: locationProvider.isLoading 
                        ? null 
                        : () {
                            if (!locationProvider.isManualEntry) return;
                            locationProvider.toggleLocationMode();
                          },
                    icon: Icon(
                      Icons.gps_fixed,
                      color: !locationProvider.isManualEntry 
                          ? Colors.deepPurple 
                          : Colors.grey,
                    ),
                    label: Text(
                      'GPS Location',
                      style: TextStyle(
                        color: !locationProvider.isManualEntry 
                            ? Colors.deepPurple 
                            : Colors.grey,
                        fontWeight: !locationProvider.isManualEntry 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: !locationProvider.isManualEntry 
                            ? Colors.deepPurple 
                            : Colors.grey,
                        width: !locationProvider.isManualEntry ? 2 : 1,
                      ),
                      backgroundColor: !locationProvider.isManualEntry 
                          ? Colors.deepPurple.withOpacity(0.1) 
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: locationProvider.isLoading 
                        ? null 
                        : () {
                            if (locationProvider.isManualEntry) return;
                            locationProvider.toggleLocationMode();
                          },
                    icon: Icon(
                      Icons.edit_location,
                      color: locationProvider.isManualEntry 
                          ? Colors.deepPurple 
                          : Colors.grey,
                    ),
                    label: Text(
                      'Manual Entry',
                      style: TextStyle(
                        color: locationProvider.isManualEntry 
                            ? Colors.deepPurple 
                            : Colors.grey,
                        fontWeight: locationProvider.isManualEntry 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: locationProvider.isManualEntry 
                            ? Colors.deepPurple 
                            : Colors.grey,
                        width: locationProvider.isManualEntry ? 2 : 1,
                      ),
                      backgroundColor: locationProvider.isManualEntry 
                          ? Colors.deepPurple.withOpacity(0.1) 
                          : null,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Location input field
            Stack(
              alignment: Alignment.centerRight,
              children: [
                CustomTextField(
                  controller: locationProvider.locationController,
                  hint: locationProvider.isManualEntry 
                      ? 'Enter your address manually' 
                      : 'Tap to get GPS Location',
                  icon: locationProvider.isManualEntry 
                      ? Icons.edit_location 
                      : Icons.location_on,
                  readOnly: !locationProvider.isManualEntry,
                  onPressed: locationProvider.isManualEntry 
                      ? null 
                      : () async {
                          try {
                            await locationProvider.fetchCurrentLocation();
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 4),
                                ),
                              );
                            }
                          }
                        },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return locationProvider.isManualEntry 
                          ? 'Please enter your address' 
                          : 'Please fetch location';
                    }
                    if (locationProvider.isManualEntry && value.length < 10) {
                      return 'Please enter a complete address';
                    }
                    return null;
                  },
                ),
                
                // Loading indicator for GPS fetch
                if (locationProvider.isLoading)
                  const Positioned(
                    right: 16,
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                
                // GPS refresh button when in GPS mode and location is already fetched
                if (!locationProvider.isManualEntry && 
                    !locationProvider.isLoading &&
                    locationProvider.locationController.text.isNotEmpty)
                  Positioned(
                    right: 16,
                    child: IconButton(
                      onPressed: () async {
                        try {
                          await locationProvider.fetchCurrentLocation();
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 4),
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.deepPurple,
                        size: 20,
                      ),
                      tooltip: 'Refresh location',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
              ],
            ),
            
            // Helper text
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                locationProvider.isManualEntry 
                    ? 'Type your complete address including area, city, and state'
                    : 'Tap the field above to automatically detect your current location',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}