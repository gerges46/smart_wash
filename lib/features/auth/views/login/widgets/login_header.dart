import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90.w,
          height: 90.w,
          decoration: BoxDecoration(
            color: AppColors.grey.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.local_car_wash,
            color: AppColors.primary,
            size: 40.sp,
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          AppStrings.loginTitle,
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
