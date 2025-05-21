import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/tab_nav_provider.dart';
import 'package:service_provider/utils/app_color.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final tabProvider = Provider.of<TabNavProvider>(context);
    return DefaultTabController(
      length: 2,
      initialIndex: tabProvider.currentIndex, // assuming you have this in provider
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (index) {
              tabProvider.setTab(index);
            },
            indicatorColor: AppColor.head,
            labelColor: AppColor.head,
            unselectedLabelColor: AppColor.white,
            tabs: const [
              Tab(
                text: 'Rental',
                icon: Icon(Icons.home),
              ),
              Tab(
                text: 'Services',
                icon: Icon(Icons.build),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Rental Tab Content')),
            Center(child: Text('Services Tab Content')),
          ],
        ),
      ),
    );
  }
}
