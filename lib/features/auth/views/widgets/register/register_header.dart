import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppSize.s20.h),
        Container(
          width: AppSize.s90.w,
          height: AppSize.s90.w,
          decoration: const BoxDecoration(
            color: AppColor.iconBackground,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person_add_alt_1_rounded,
            color: AppColor.primaryColor,
            size: AppSize.s45,
          ),
        ),
        SizedBox(height: AppSize.s25.h),
        Text(
          AppStrings.registerTitle,
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.textPrimary,
          ),
        ),
        SizedBox(height: AppSize.s8.h),
        Text(
          AppStrings.registerSubtitle,
          style: TextStyle(fontSize: 15.sp, color: AppColor.textSecondary),
        ),
      ],
    );
  }
}
