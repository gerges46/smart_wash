import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45.r,
          backgroundColor: AppColors.secondary.withOpacity(0.2),
          child: Icon(
            Icons.local_car_wash,
            color: AppColors.primary,
            size: 40.sp,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          AppStrings.registerTitle,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
