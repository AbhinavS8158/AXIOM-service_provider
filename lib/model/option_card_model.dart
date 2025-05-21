import 'package:flutter/material.dart';

class OptionCardModel {
  final IconData icon;
  final String title;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  OptionCardModel({
    required this.icon,
     required this.title, 
     required this.color, 
     required this.iconColor,
      required this.onTap
      });
}