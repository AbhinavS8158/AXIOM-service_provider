import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/carousel_provider.dart';
import 'package:service_provider/model/propertycard_form_model.dart';

import 'image_preview_screen.dart';
// ... existing imports
// ... existing imports

class ImageCarouselWidget extends StatelessWidget {
  final PropertycardFormModel property;

  const ImageCarouselWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    if (property.photoPath.isEmpty) {
      return const Center(child: Text("No images available"));
    }

    final totalImages = property.photoPath.length;

    return ChangeNotifierProvider(
      create: (_) => CarouselProvider(),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 1. Carousel Slider
          Builder(
            builder: (context) {
              return CarouselSlider(
                options: CarouselOptions(
                  height: 250,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: totalImages > 1,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    context.read<CarouselProvider>().updateIndex(index);
                  },
                ),
                items: property.photoPath.asMap().entries.map((entry) {
                  return _buildImageItem(
                    context,
                    entry.key,
                    entry.value.toString(),
                  );
                }).toList(),
              );
            },
          ),

          // 2. Image Counter Badge (Top Right)
          Positioned(
            top: 15,
            right: 25, // Adjusted for the padding in buildImageItem
            child: Consumer<CarouselProvider>(
              builder: (context, state, child) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${state.currentIndex + 1} / $totalImages',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),

          // 3. Dot Indicators (Bottom Center)
          Positioned(
            bottom: 12,
            child: Consumer<CarouselProvider>(
              builder: (context, state, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: property.photoPath.asMap().entries.map((entry) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(
                          state.currentIndex == entry.key ? 0.9 : 0.4,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // _buildImageItem and _buildErrorPlaceholder remain the same...
  Widget _buildImageItem(BuildContext context, int index, String url) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ImagePreviewScreen(
            images: property.photoPath,
            initialIndex: index,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
            child: url.isEmpty
                ? _buildErrorPlaceholder()
                : FadeInImage.assetNetwork(
                    placeholder: 'assets/img/pictures.png',
                    image: url,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        _buildErrorPlaceholder(),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: Colors.grey.shade300,
      child: const Icon(Icons.broken_image_outlined, color: Colors.grey, size: 50),
    );
  }
}