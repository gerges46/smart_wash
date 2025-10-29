import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/core/utils/date_time_formatter.dart';

class BookingsList extends StatelessWidget {
  final List<Map<String, dynamic>> bookings;
  const BookingsList({super.key, required this.bookings});

  Widget _buildRating(double rating) {
    if (rating == 0) {
      return const Text(
        "لم يتم التقييم بعد",
        style: TextStyle(color: Colors.grey, fontSize: 13),
      );
    }

    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: AppColors.primary,
          size: 16.sp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: bookings.length,
      separatorBuilder: (_, __) => SizedBox(height: AppSize.s12.h),
      itemBuilder: (context, i) {
        final b = bookings[i];
        final bool isCompleted = b['status'] == "مكتمل";
        final bool isPaid = b['isPaid'] ?? false;
        final double rating = (b['rating'] ?? 0).toDouble();
        final String note = b['note'] ?? "";

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
          padding: EdgeInsets.all(AppPadding.p16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 عنوان الخدمة + الحالة
              Row(
                children: [
                  CircleAvatar(
                    radius: AppSize.s24.r,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.cleaning_services,
                      color: AppColors.primary,
                      size: AppSize.s20.sp,
                    ),
                  ),
                  SizedBox(width: AppSize.s12.w),
                  Expanded(
                    child: Text(
                      b['service'] ?? "خدمة غير معروفة",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSize.s16.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
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
                      b['status'],
                      style: TextStyle(
                        color:
                            isCompleted ? AppColors.success : AppColors.warning,
                        fontWeight: FontWeight.w600,
                        fontSize: AppSize.s12.sp,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSize.s10.h),

              /// 🗓️ التاريخ والوقت
              Text(
                formatDateTime(b['date'], b['time']),
                style: TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: AppSize.s13.sp,
                ),
              ),

              SizedBox(height: AppSize.s6.h),

              /// 💵 السعر والعنوان
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

              SizedBox(height: AppSize.s8.h),

              /// 💰 حالة الدفع
              Row(
                children: [
                  Icon(
                    isPaid ? Icons.check_circle : Icons.cancel,
                    color: isPaid ? AppColors.success : AppColors.error,
                    size: 18.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    isPaid ? "تم الدفع ✅" : "لم يتم الدفع ❌",
                    style: TextStyle(
                      color: isPaid ? AppColors.success : AppColors.error,
                      fontSize: AppSize.s13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSize.s8.h),

              /// 🌟 التقييم
              Row(
                children: [
                  Icon(Icons.star, color: AppColors.primary, size: 18.sp),
                  SizedBox(width: 6.w),
                  _buildRating(rating),
                ],
              ),

              if (note.isNotEmpty) ...[
                SizedBox(height: AppSize.s6.h),
                Text(
                  "💬 رسالة التقييم: $note",
                  style: TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: AppSize.s13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
