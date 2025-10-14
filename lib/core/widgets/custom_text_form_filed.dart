
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';


class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hint,
    required this.controller,
    this.onSaved,
    this.onChanged,
    this.isSecure,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.radius,
    this.isEmail = false,
    this.verticalPadding,
    this.keyboardType,
    this.onTap,
    this.readOnly = false,
  });

  final String? hint;
  final TextEditingController controller;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final bool? isSecure;
  final int? maxLength;
  final IconButton? prefixIcon;
  final IconButton? suffixIcon;
  final String? Function(String?)? validator;
  final BorderRadius? radius;
  final bool isEmail;
  final double? verticalPadding;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p24,
        vertical: verticalPadding ?? AppPadding.p17,
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextFormField(
          onTap: onTap,
          readOnly: readOnly,
          keyboardType: keyboardType,
          maxLength: maxLength,
          obscureText: isSecure ?? false,
          controller: controller,
          onSaved: onSaved,
          validator: (data) {
            String value = controller.text.trim();
        
            if (value.isEmpty) return "$hint لا يجب أن يكون فارغًا!";
        
             
        
            // ✅ شرط الإيميل
            if (isEmail && (!value.contains('@') || !value.endsWith('.com'))) {
              return "'.com' يجب أن يحتوي البريد الإلكتروني على '@' وينتهي بـ ";
            }
        
            return null;
          },
          onChanged: onChanged,
          maxLines: isSecure == true ? 1 : maxLength, // ✅ فقط 3 أسطر كحد أقصى
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              // color: AppColor.hintTextColor,
              fontSize: AppSize.s14.sp,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: radius ?? BorderRadius.circular(AppSize.s8),
            ),
            filled: true,
            fillColor:AppColor.fillFiledColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: radius ?? BorderRadius.circular(AppSize.s8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: radius ?? BorderRadius.circular(AppSize.s8),
            ),
          ),
        ),
      ),
    );
  }
}