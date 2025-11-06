import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/filter_provider.dart';
import 'package:service_provider/utils/app_color.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;

  const FilterChipWidget({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    // Access provider
    final filterProvider = Provider.of<FilterProvider>(context);
    final bool isSelected = filterProvider.selectedFilter == label;

    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) {
          filterProvider.updateFilter(label);
        },
        backgroundColor: Colors.white,
        selectedColor: AppColor.forgot,
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.grey.shade600,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? AppColor.forgot : Colors.grey.shade300,
          ),
        ),
        elevation: isSelected ? 4 : 0,
        shadowColor: AppColor.forgot.withOpacity(0.3),
      ),
    );
  }
}
