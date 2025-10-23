import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/core/utils/date_time_formatter.dart';

class BookingsList extends StatelessWidget {
  final List<Map<String, dynamic>> bookings;
  const BookingsList({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: bookings.length,
      separatorBuilder: (_, __) => SizedBox(height: AppSize.s12.h),
      itemBuilder: (context, i) {
        final b = bookings[i];
        final bool isCompleted = b['status'] == "مكتمل";

        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSize.s16.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppPadding.p16.w,
              vertical: AppPadding.p8.h,
            ),
            leading: CircleAvatar(
              radius: AppSize.s26.r,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Icon(
                Icons.local_car_wash,
                color: AppColors.primary,
                size: AppSize.s24.sp,
              ),
            ),
            title: Text(
              b['service'] as String, // تم تعديلها من 'title'
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppSize.s16.sp,
                color: AppColors.primary,
              ),
            ),
                    subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSize.s4.h),
            Text(
              formatDateTime(b['date'], b['time']), // استخدمنا الدالة هنا
              style: TextStyle(
                color: AppColors.darkGrey,
                fontSize: AppSize.s13.sp,
              ),
            ),
    SizedBox(height: AppSize.s6.h),
    Text(
      "السعر: ${b['price']}",
      style: TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: AppSize.s14.sp,
      ),
    ),
    SizedBox(height: AppSize.s4.h),
    Text(
      "العنوان: ${b['address']}",
      style: TextStyle(
        color: AppColors.darkGrey,
        fontSize: AppSize.s13.sp,
      ),
    ),
  ],
),

            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p10.w,
                    vertical: AppPadding.p4.h,
                  ),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSize.s12.r),
                  ),
                  child: Text(
                    b['status'] as String,
                    style: TextStyle(
                      color: isCompleted ? AppColors.success : AppColors.warning,
                      fontWeight: FontWeight.w600,
                      fontSize: AppSize.s12.sp,
                    ),
                  ),
                ),
                SizedBox(height: AppSize.s8.h),
              
              ],
            ),
            
          ),
        );
      },
    );
  }
}
