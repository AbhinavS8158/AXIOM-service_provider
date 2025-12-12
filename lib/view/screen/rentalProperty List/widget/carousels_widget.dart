import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/model/propertycard_form_model.dart';

import 'image_preview_screen.dart';

class ImageCarouselWidget extends StatelessWidget {
  final PropertycardFormModel property;

  const ImageCarouselWidget({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    if (property.photoPath.isEmpty) {
      return const Center(child: Text("No images available"));
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: 250,
        viewportFraction: 1.0,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
      items: property.photoPath.asMap().entries.map((entry) {
        final index = entry.key;
        final url = (entry.value ?? '').toString();

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ImagePreviewScreen(
                  images: property.photoPath,
                  initialIndex: index,
                ),
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
            child: url.isEmpty
                ? Container(
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.broken_image_outlined,
                      color: Colors.grey,
                      size: 50,
                    ),
                  )
                : FadeInImage.assetNetwork(
                    placeholder: 'assets/img/pictures.png', // forward slashes
                    image: url,
                    fit: BoxFit.cover,
                    // show fallback when network image fails
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.broken_image_outlined,
                          color: Colors.grey,
                          size: 50,
                        ),
                      );
                    },
                  ),
          ),
        );
      }).toList(),
    );
  }
}
