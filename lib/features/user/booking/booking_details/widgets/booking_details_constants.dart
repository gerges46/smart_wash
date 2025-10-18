import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class BookingDetailsStyles {
  static final title = TextStyle(
    fontSize: AppSize.s20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static final subtitle = TextStyle(
    fontSize: AppSize.s16.sp,
    color: AppColors.darkGrey,
  );

  static final detailTitle = TextStyle(
    fontSize: AppSize.s14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGrey,
  );

  static final detailValue = TextStyle(
    fontSize: AppSize.s14.sp,
    color: AppColors.black,
  );

  static final buttonText = TextStyle(
    fontSize: AppSize.s16.sp,
    fontWeight: FontWeight.bold,
  );

  static BoxDecoration get cardDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(AppSize.s20.r),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration buttonDecoration(bool isPrimary) => BoxDecoration(
    borderRadius: BorderRadius.circular(AppSize.s25.r),
    gradient: isPrimary
        ? LinearGradient(
            colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
          )
        : null,
    color: isPrimary ? null : AppColors.cancel,
    boxShadow: [
      BoxShadow(
        color: (isPrimary ? AppColors.primary : AppColors.cancel).withOpacity(
          0.3,
        ),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );
}
