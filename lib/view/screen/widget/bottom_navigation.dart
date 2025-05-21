import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/bottom_nav_provider.dart';
import 'package:service_provider/view/screen/add%20Property/add_property.dart';
import 'package:service_provider/view/screen/home%20Screen/home_screen.dart';
import 'package:service_provider/view/screen/widget/bottom_nav_item.dart';

class BottomNav extends StatelessWidget {
  final List<Widget> _pages = [
    HomeScreen(),
    AddPoperty(),
    Center(child: Text('Transction')),
    Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      body: _pages[bottomNavProvider.currentIndex],
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
