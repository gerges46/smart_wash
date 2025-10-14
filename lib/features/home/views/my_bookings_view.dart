import 'package:flutter/material.dart';
import 'package:smart_clean/core/constants/app_color.dart';

class MyBookingsView extends StatelessWidget {
  const MyBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "صفحة حجوزاتي 📅",
        style: TextStyle(
          fontSize: 20,
          color: AppColor.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
