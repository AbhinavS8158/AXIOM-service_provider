import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/bottom_nav_provider.dart';
import 'package:service_provider/utils/app_color.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Container(
      color: AppColor.bg,
      child: CrystalNavigationBar(
        currentIndex: bottomNavProvider.currentIndex,
        height: 10,
        unselectedItemColor: AppColor.bg,
        borderWidth: 2,
        outlineBorderColor: AppColor.white,
        backgroundColor: AppColor.white,
        onTap: (index) {
          bottomNavProvider.setIndex(index);
        },
        items: [
          CrystalNavigationBarItem(
            icon: Icons.home,
            unselectedIcon: Icons.home,
            unselectedColor: Colors.grey,
            selectedColor: AppColor.forgot,
          ),

          CrystalNavigationBarItem(
            icon: Icons.add,
            unselectedIcon: Icons.add,
            unselectedColor: Colors.grey,
            selectedColor: AppColor.forgot,
          ),

          CrystalNavigationBarItem(
            icon: Icons.assignment,
            unselectedIcon: Icons.assignment,
            unselectedColor: Colors.grey,
            selectedColor: AppColor.forgot,
          ),
          CrystalNavigationBarItem(
            icon: Icons.person,
            unselectedIcon: Icons.person,
            unselectedColor: Colors.grey,
            selectedColor: AppColor.forgot,
          ),
        ],
      ),
    );
  }
}
