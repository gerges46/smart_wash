import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/features/user/booking/prebooking/widgets/info_row.dart';
import 'package:smart_clean/features/user/booking/prebooking/widgets/status_chip.dart';

class BookingCard extends StatelessWidget {
  final Map<String, dynamic> lastBooking;
  const BookingCard({super.key, required this.lastBooking});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(blurRadius: 3, offset: const Offset(0, 1))],
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(10.w),
                child: Icon(
                  Icons.local_car_wash,
                  color: AppColors.primary,
                  size: 26.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                lastBooking['service'],
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              StatusChip(status: lastBooking['status']),
            ],
          ),

          SizedBox(height: 25.h),
          InfoRow(
            icon: Icons.calendar_today,
            title: "التاريخ",
            value: lastBooking['date'],
          ),
          SizedBox(height: 12.h),
          InfoRow(
            icon: Icons.access_time,
            title: "الوقت",
            value: lastBooking['time'],
          ),
        ],
      ),
    );
  }
}
