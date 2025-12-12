import 'package:flutter/material.dart';

class ImagePreviewScreen extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const ImagePreviewScreen({
    Key? key,
    required this.images,
    required this.initialIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: initialIndex);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return InteractiveViewer(
            minScale: 1.0,
            maxScale: 4.0,
            child: Center(
              child: Image.network(
                images[index],
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loading) {
                  if (loading == null) return child;
                  return const CircularProgressIndicator(color: Colors.white);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
