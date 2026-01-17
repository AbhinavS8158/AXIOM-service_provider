import 'package:flutter/material.dart';
import 'package:service_provider/utils/app_color.dart';

class AboutAppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AboutAppAppBar({
    super.key,
    this.title = 'About App',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColor.forgot,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
