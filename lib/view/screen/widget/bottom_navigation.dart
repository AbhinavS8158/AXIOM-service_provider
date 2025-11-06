import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/bottom_nav_provider.dart';
import 'package:service_provider/view/screen/add%20Property/add_property.dart';
import 'package:service_provider/view/screen/home%20Screen/home_screen.dart';
import 'package:service_provider/view/screen/widget/bottom_nav_item.dart';

class BottomNav extends StatelessWidget {
  final int index;
  final List<Widget> _pages = [
    HomeScreen(),
    AddPoperty(),
    Center(child: Text('Transaction')),
    Center(child: Text('Profile')),
  ];

  BottomNav({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    // If arguments passed and it's an int, update the provider's index
    if (args is int && bottomNavProvider.currentIndex != args) {
      Future.microtask(() => bottomNavProvider.setIndex(args));
    }

    return Scaffold(
      body: _pages[bottomNavProvider.currentIndex],
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
