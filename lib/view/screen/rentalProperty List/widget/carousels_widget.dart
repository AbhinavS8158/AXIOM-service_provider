import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/rental_form_provider.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class ImageCarouselWidget extends StatelessWidget {
  final PropertycardFormModel property;

  // ignore: use_super_parameters
  const ImageCarouselWidget({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (property.photoPath.isEmpty) {
      return const Center(child: Text("No images available"));
    }

    return Stack(
      children: [
        Consumer<RentalFormProvider>(
          builder: (context, value, child) =>
           CarouselSlider(
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1.0,
              enlargeCenterPage:true,
              
              autoPlay: true,
            ),
            items: property.photoPath.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        image: NetworkImage(url),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ), 
          
        ),
      ],
    );
  }
}
