import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(AppSize.s16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.greetingTitle,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: AppSize.s18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSize.s6.h),
                Text(
                  AppStrings.greetingSubtitle,
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.8),
                    fontSize: AppSize.s13.sp,
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: AppSize.s30.r,
            backgroundColor: Colors.white24,
            child: const Icon(Icons.local_car_wash, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}