// lib/features/auth/forgot_password/widgets/forgot_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class ForgotHeader extends StatelessWidget {
  const ForgotHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40.r,
          backgroundColor: AppColors.secondary.withOpacity(0.12),
          child: Icon(Icons.lock_reset, color: AppColors.primary, size: 38.sp),
        ),
        SizedBox(height: AppSize.s16.h),
        Text(
          AppStrings.forgotTitle,
          style: TextStyle(
            fontSize: AppSize.s20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSize.s8.h),
        Text(
          AppStrings.forgotSubtitle,
          style: TextStyle(fontSize: AppSize.s14.sp, color: AppColors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
