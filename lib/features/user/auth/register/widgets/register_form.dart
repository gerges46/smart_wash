import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  Widget _buildTextField(
    String hint,
    IconData icon, {
    bool isPassword = false,
  }) {
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.primary),
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.greyText),
        filled: true,
        fillColor: AppColors.fieldBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField(AppStrings.fullName, Icons.person_outline),
        SizedBox(height: 16.h),
        _buildTextField(AppStrings.email, Icons.email_outlined),
        SizedBox(height: 16.h),
        _buildTextField(AppStrings.phone, Icons.phone_outlined),
        SizedBox(height: 16.h),
        _buildTextField(
          AppStrings.password,
          Icons.lock_outline,
          isPassword: true,
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          AppStrings.confirmPassword,
          Icons.lock_outline,
          isPassword: true,
        ),
      ],
    );
  }
}
