import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class OTPHeader extends StatelessWidget {
  const OTPHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.sms, color: AppColors.primary, size: 80.sp),
        SizedBox(height: AppSize.s16.h),
        Text(
          AppStrings.otpTitle,
          style: TextStyle(
            fontSize: AppSize.s22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSize.s8.h),
        Text(
          AppStrings.otpSubtitle,
          style: TextStyle(fontSize: AppSize.s14.sp, color: AppColors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
