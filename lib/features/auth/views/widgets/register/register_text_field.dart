import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class RegisterTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType keyboard;
  final bool obscure;
  final bool isNameField;

  const RegisterTextField({
    super.key,
    required this.label,
    required this.hint,
    this.keyboard = TextInputType.text,
    this.obscure = false,
    this.isNameField = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.textPrimary,
          ),
        ),
        SizedBox(height: 6.h),
        TextField(
          keyboardType: keyboard,
          obscureText: obscure,
          textAlign: isNameField ? TextAlign.right : TextAlign.left,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColor.hintTextColor,
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: AppColor.fillFiledColor,
            contentPadding: EdgeInsets.symmetric(
              vertical: AppPadding.p14.h,
              horizontal: AppPadding.p16.w,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppColor.borderRadius,
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppColor.borderRadius,
              borderSide: BorderSide(color: AppColor.primaryColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
