import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class PaymentMethods {
  static const String cash = "cash";
  static const String card = "card";
  static const String wallet = "wallet";
}

class PaymentTextStyles {
  static final header = TextStyle(
    fontSize: AppSize.s22.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static final buttonText = TextStyle(
    fontSize: AppSize.s20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle option(bool selected) => TextStyle(
    fontSize: AppSize.s18.sp,
    fontWeight: FontWeight.bold,
    color: selected ? AppColors.primary : AppColors.black87,
  );
}

class PaymentBoxDecorations {
  static BoxDecoration optionCard(bool selected) => BoxDecoration(
    color: selected ? AppColors.primary.withOpacity(0.1) : AppColors.white,
    borderRadius: BorderRadius.circular(AppSize.s20.r),
    border: Border.all(
      color: selected ? AppColors.primary : AppColors.lightGrey,
      width: selected ? 2 : 1,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static final confirmButton = BoxDecoration(
    borderRadius: BorderRadius.circular(AppSize.s30.r),
    gradient: LinearGradient(
      colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.primary.withOpacity(0.4),
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
  );
}
