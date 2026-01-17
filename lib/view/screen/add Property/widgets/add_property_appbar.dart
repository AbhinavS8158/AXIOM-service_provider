import 'package:flutter/material.dart';
import 'package:service_provider/utils/app_color.dart';

class AddPropertyAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AddPropertyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Add Property"),
      centerTitle: true,
      backgroundColor: AppColor.bg,
      bottom: const TabBar(
        indicatorColor: AppColor.forgot,
        labelColor: AppColor.forgot,
        unselectedLabelColor: AppColor.login,
        tabs: [
          Tab(icon: Icon(Icons.house), text: 'Rental'),
          Tab(icon: Icon(Icons.apartment), text: 'Sell'),
          Tab(icon: Icon(Icons.meeting_room_outlined), text: 'PG'),
        ],
      ),
    );
  }

  /// Required when using a custom AppBar widget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);
}
