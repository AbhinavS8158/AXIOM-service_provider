import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/home%20Screen/home_screen.dart';
import 'package:service_provider/view/screen/pgProperty List/pg_property_list.dart';
import 'package:service_provider/view/screen/rentalProperty List/rental_property_listing.dart';
import 'package:service_provider/view/screen/sellProperty List/sell_property_list.dart';


class PropertyCategoriesSection extends StatelessWidget {
  const PropertyCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        const SizedBox(height: 24),
        _buildCategoryRow(context),
      ],
    );
  }

  // ---------------- HEADER ----------------
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColor.blk,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Choose your property type',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.grey,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColor.forgot.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            '3 Types',
            style: TextStyle(
              fontSize: 12,
              color: AppColor.forgot,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- CATEGORY ROW ----------------
  Widget _buildCategoryRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: CategoryIcon(
            icon: Icons.apartment,
            label: 'For Rent',
            subtitle: 'Monthly rentals',
            color: const Color(0xFF4F46E5),
            onTap: () {
              log('Tapped For Rent');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RentPropertyListingScreen(),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: CategoryIcon(
            icon: Icons.house,
            label: 'For Sale',
            subtitle: 'Buy properties',
            color: const Color(0xFF059669),
            onTap: () {
              log('Tapped For Sale');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SellPropertyList(),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: CategoryIcon(
            icon: Icons.bed,
            label: 'PG',
            subtitle: 'Paying guests',
            color: AppColor.red,
            onTap: () {
              log('Tapped PG');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PgPropertList(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
