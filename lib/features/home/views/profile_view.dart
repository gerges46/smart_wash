import 'package:flutter/material.dart';
import 'package:smart_clean/core/constants/app_color.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "الملف الشخصي 👤",
        style: TextStyle(
          fontSize: 20,
          color: AppColor.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
