import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p16.w),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppSize.s16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.welcome,
            style: TextStyle(
              fontSize: AppSize.s14.sp,
              color: AppColor.textSecondary,
            ),
          ),
          SizedBox(height: AppSize.s4.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.dearCustomer,
                  style: TextStyle(
                    fontSize: AppSize.s18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p10.w,
                  vertical: AppPadding.p4.h,
                ),
                decoration: BoxDecoration(
                  color: AppColor.lightBlueBackground,
                  borderRadius: BorderRadius.circular(AppSize.s20.r),
                ),
                child: Text(
                  AppStrings.client,
                  style: TextStyle(
                    fontSize: AppSize.s13.sp,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.s20.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today_rounded, size: 20),
                  label: const Text(AppStrings.newBooking),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    foregroundColor: AppColor.white,
                    padding: EdgeInsets.symmetric(vertical: AppPadding.p12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s12.r),
                    ),
                  ),
                ),
              ),
              SizedBox(width: AppSize.s12.w),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.access_time_rounded, size: 20),
                  label: const Text(AppStrings.previousBooking),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: AppPadding.p12.h),
                    backgroundColor: AppColor.lightBlueBackground,
                    side: const BorderSide(color: Colors.transparent),
                    foregroundColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s12.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
