import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class OTPInputFields extends StatelessWidget {
  final TextEditingController controller;
  const OTPInputFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Container(
          width: 55.w,
          height: 55.w,
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            color: AppColors.lightGrey, // لون خلفية خفيف
            borderRadius: BorderRadius.circular(
              AppSize.s8.r,
            ), // مربعة مع حواف ناعمة
            border: Border.all(
              color: AppColors.primary.withOpacity(0.4),
              width: 1.5,
            ),
          ),
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(
              counterText: "",
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: AppSize.s22.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 3) {
                FocusScope.of(
                  context,
                ).nextFocus(); // ينتقل تلقائيًا للحقل التالي
              }
            },
          ),
        ),
      ),
    );
  }
}
