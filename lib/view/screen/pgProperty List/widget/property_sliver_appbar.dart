import 'package:flutter/material.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/widget/bottom_navigation.dart';
import 'package:service_provider/view/screen/widget/property_header.dart';


class PropertySliverAppBar extends StatelessWidget {
  const PropertySliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: AppColor.transperent,

      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColor.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColor.blk.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColor.blk,
            size: 20,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) =>  BottomNav()),
            );
          },
        ),
      ),

      flexibleSpace: const FlexibleSpaceBar(
        background: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColor.forgot,
                Color.fromARGB(255, 169, 106, 224),
                AppColor.forgot,
              ],
            ),
          ),
          child: PropertyHeader(),
        ),
      ),
    );
  }
}
