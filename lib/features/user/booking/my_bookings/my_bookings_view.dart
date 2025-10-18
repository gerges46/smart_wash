import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'widgets/bookings_list.dart';
import 'widgets/bookings_header.dart';

class MyBookingsView extends StatelessWidget {
  const MyBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bookings = [
      {
        "title": AppStrings.service2,
        "datetime": "2025-10-20 10:00",
        "status": "جارٍ",
        "price": "150 ج.م",
      },
      {
        "title": AppStrings.service3,
        "datetime": "2025-09-12 14:00",
        "status": "مكتمل",
        "price": "300 ج.م",
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const BookingsHeader(),
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.myBookingsSubtitle,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: AppSize.s16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppSize.s16.h),
            Expanded(child: BookingsList(bookings: bookings)),
          ],
        ),
      ),
    );
  }
}
