import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/features/user/booking/prebooking/widgets/info_row.dart';
import 'package:smart_clean/features/user/booking/prebooking/widgets/status_chip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_clean/core/routes/app_router.dart';

class BookingCard extends StatelessWidget {
  final Map<String, dynamic> lastBooking;
  const BookingCard({super.key, required this.lastBooking});

  String _formatDate(dynamic dateValue) {
    try {
      if (dateValue == null) return "غير محدد";
      DateTime date = dateValue is Timestamp
          ? dateValue.toDate()
          : DateTime.tryParse(dateValue.toString()) ?? DateTime.now();
      return "${date.day}/${date.month}/${date.year}";
    } catch (e) {
      return "غير معروف";
    }
  }

  Widget _buildRating(dynamic rating) {
    if (rating == null || rating == 0) {
      return const Text(
        "لم يتم التقييم بعد",
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    final int stars =
        (rating is num) ? rating.toInt() : int.tryParse(rating.toString()) ?? 0;
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < stars ? Icons.star : Icons.star_border,
          color: AppColors.primary,
          size: 20.sp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String service = lastBooking['service'] ?? "غير محدد";
    final String status = lastBooking['status'] ?? "غير معروف";
    final String date = _formatDate(lastBooking['date']);
    final String time = lastBooking['time']?.toString() ?? "غير محدد";
    final String address = lastBooking['address'] ?? "غير محدد";
    final dynamic price = lastBooking['price'] ?? "غير محدد";
    final bool isPaid = lastBooking['isPaid'] ?? false;
    final dynamic rating = lastBooking['rating'];
    final String? ratingMessage = lastBooking['note'];

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
          /// 🔹 عنوان الخدمة + الحالة
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(10.w),
                child: Icon(
                  Icons.cleaning_services,
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

          InfoRow(icon: Icons.calendar_today, title: "التاريخ", value: date),
          SizedBox(height: 12.h),
          InfoRow(icon: Icons.access_time, title: "الوقت", value: time),
          SizedBox(height: 12.h),
          InfoRow(icon: Icons.location_on, title: "العنوان", value: address),
          SizedBox(height: 12.h),
          InfoRow(icon: Icons.attach_money, title: "السعر", value: "$price جنيه"),
          SizedBox(height: 12.h),
          InfoRow(
            icon: Icons.payment,
            title: "حالة الدفع",
            value: isPaid ? "✅ تم الدفع" : "❌ لم يتم الدفع بعد",
          ),

          SizedBox(height: 20.h),

          /// 🌟 التقييم
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: AppColors.primary),
              SizedBox(width: 8.w),
              Expanded(child: _buildRating(rating)),
            ],
          ),

          SizedBox(height: 12.h),

          /// 💬 رسالة التقييم أو زر التقييم
          if (ratingMessage != null && ratingMessage.isNotEmpty)
            Text(
              "💬 رسالة التقييم: $ratingMessage",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            )
          else
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                icon: const Icon(Icons.rate_review, color: Colors.white),
                label: const Text(
                  "قيّم الخدمة الآن",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () {
  Navigator.pushNamed(
    context,
    Routes.ratingRoute,
    arguments: lastBooking['id'], // تمرير معرف الحجز
  );
},

              ),
            ),
        ],
      ),
    );
  }
}
