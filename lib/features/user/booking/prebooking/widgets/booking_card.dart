import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/features/user/booking/prebooking/widgets/info_row.dart';
import 'package:smart_clean/features/user/booking/prebooking/widgets/status_chip.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // ✅ ضروري عشان Timestamp

class BookingCard extends StatelessWidget {
  final Map<String, dynamic> lastBooking;
  const BookingCard({super.key, required this.lastBooking});

  /// 🕒 تنسيق التاريخ والوقت بشكل واضح
  String _formatDate(dynamic dateValue) {
    try {
      if (dateValue == null) return "غير محدد";

      DateTime date = dateValue is Timestamp
          ? dateValue.toDate()
          : DateTime.tryParse(dateValue.toString()) ?? DateTime.now();

      return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
    } catch (e) {
      return "غير معروف";
    }
  }

  @override
  Widget build(BuildContext context) {
    final String service = lastBooking['service'] ?? "غير محدد";
    final String status = lastBooking['status'] ?? "غير معروف";
    final String date = _formatDate(lastBooking['date']);
    final String time = lastBooking['time']?.toString() ?? "غير محدد";

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            offset: const Offset(0, 1),
            color: Colors.black12,
          ),
        ],
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 العنوان
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
                service,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              StatusChip(status: status),
            ],
          ),

          SizedBox(height: 25.h),

          /// 🗓 التاريخ
          InfoRow(
            icon: Icons.calendar_today,
            title: "التاريخ",
            value: date,
          ),
          SizedBox(height: 12.h),

          /// ⏰ الوقت
          InfoRow(
            icon: Icons.access_time,
            title: "الوقت",
            value: time,
          ),
        ],
      ),
    );
  }
}
