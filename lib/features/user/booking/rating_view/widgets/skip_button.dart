import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback? onPressed; // غيرت لـ nullable
  final bool isLoading;
  
  const SkipButton({
    super.key, 
    required this.onPressed, // أو required this.onPressed? لو عايز تجعله optional
    this.isLoading = false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: Colors.transparent,
          border: Border.all(
            color: AppColors.primary.withOpacity(0.5),
            width: 2,
          ),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 18.h,
                  width: 18.h,
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  "تخطي التقييم",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
        ),
      ),
    );
  }
}