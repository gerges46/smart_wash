import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/core/routes/app_router.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () =>
                Navigator.pushNamed(context, Routes.newBookingRoute),
            icon: const Icon(Icons.add),
            label: const Text(AppStrings.newBooking),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(vertical: AppPadding.p14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12.r),
              ),
            ),
          ),
        ),
        SizedBox(width: AppSize.s12.w),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () =>
                Navigator.pushNamed(context, Routes.preBookingRoute),
            icon: const Icon(Icons.event),
            label: const Text(AppStrings.preBooking),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              padding: EdgeInsets.symmetric(vertical: AppPadding.p14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
