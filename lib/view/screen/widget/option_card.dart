import 'package:flutter/material.dart';
import 'package:service_provider/model/option_card_model.dart';



class OptionCard extends StatelessWidget {
  final OptionCardModel model;

  const OptionCard({super.key, required this.model, required String title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: model.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          color: model.color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: model.iconColor.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  model.icon,
                  size: 32,
                  color: model.iconColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                model.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: model.iconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
