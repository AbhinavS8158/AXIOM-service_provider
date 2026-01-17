import 'package:flutter/material.dart';
import 'package:service_provider/utils/app_color.dart';

class PropertyBanner extends StatelessWidget {
  final String imageAsset;
  final String placeholderAsset;
  final double height;
  final BorderRadius borderRadius;

  const PropertyBanner({
    super.key,
    required this.imageAsset,
    required this.placeholderAsset,
    this.height = 180,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: borderRadius,
          child: Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColor.blk.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: FadeInImage(
              placeholder: AssetImage(placeholderAsset),
              image: AssetImage(imageAsset),
              fit: BoxFit.fill, // final image fills container
              placeholderFit:
                  BoxFit.contain, // prevents placeholder stretching
              fadeInDuration: const Duration(milliseconds: 300),
            ),
          ),
        ),
      ],
    );
  }
}
