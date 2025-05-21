import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/login_provider.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/pgProperty%20List/pg_propert_list.dart';
import 'package:service_provider/view/screen/rentalProperty%20List/rental_property_listing.dart';
import 'package:service_provider/view/screen/sellProperty%20List/sell_property_list.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context);
    return Scaffold(
      backgroundColor: AppColor.bg,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Logo & Chat
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'AXIOM',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColor.forgot,
                    ),
                  ),
                  Icon(Icons.chat_bubble_outline, color: AppColor.forgot),
                ],
              ),
              const SizedBox(height: 20),

              // Banner Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://img.freepik.com/free-psd/real-estate-horizontal-banner-template_23-2148991862.jpg', // Use your own asset if needed
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // Category Title
              const Text(
                'Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Category Row
              // Category Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CategoryIcon(
                    icon: Icons.apartment,
                    label: 'For Rent',
                    onTap: () {
                      print("Tapped For Rent");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RentPropertyListingScreen()));
                      // Navigate or perform action
                    },
                  ),
                  CategoryIcon(
                    icon: Icons.house,
                    label: 'For Sale',
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>SellPropertyList()));
                      print("Tapped For Sale");
                    },
                  ),
                  CategoryIcon(
                    icon: Icons.bed,
                    label: 'PG',
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>PgPropertList()));
                      print("Tapped PG");
                    },
                  ),
                  CategoryIcon(
                    icon: Icons.business,
                    label: 'Commercial',
                    onTap: () {
                      print("Tapped Commercial");
                    },
                  ),
                ],
              ),

              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.logout(context);
                    },
                    child: Text("Logout"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const CategoryIcon({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: AppColor.white,
            radius: 28,
            child: Icon(icon, color: AppColor.forgot),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
