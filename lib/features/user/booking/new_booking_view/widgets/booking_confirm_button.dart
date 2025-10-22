import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class BookingConfirmButton extends StatelessWidget {
  final VoidCallback onConfirm;

  const BookingConfirmButton({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onConfirm,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: AppPadding.p18.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s30.r),
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: AppSize.s10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            "تأكيد الحجز", // 🟢 بالعربي
            style: TextStyle(
              color: Colors.white,
              fontSize: AppSize.s18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
