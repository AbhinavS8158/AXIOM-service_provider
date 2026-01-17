import 'package:flutter/material.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/widget/bottom_navigation.dart';

class PropertiesSliverAppBar extends StatelessWidget {
  final String title;
  final String tagLabel;

  const PropertiesSliverAppBar({
    super.key,
    this.title = 'Properties',
    this.tagLabel = 'For Rent',
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,

      // ---------------- BACK BUTTON ----------------
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) =>  BottomNav()),
            );
          },
        ),
      ),

      // ---------------- FLEXIBLE SPACE ----------------
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColor.forgot,
                AppColor.forgot,
                Color.fromARGB(255, 169, 106, 224),
                AppColor.forgot,
              ],
            ),
          ),
          child: Stack(
            children: [
              _buildDecorations(),
              _buildTitleSection(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- DECORATIVE CIRCLES ----------------
  Widget _buildDecorations() {
    return Stack(
      children: [
        Positioned(
          top: -20,
          right: -20,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        Positioned(
          top: 40,
          right: 60,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- TITLE SECTION ----------------
  Widget _buildTitleSection() {
    return Positioned(
      left: 50,
      bottom: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Text(
                  tagLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.home_outlined,
                color: Colors.white.withOpacity(0.8),
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
