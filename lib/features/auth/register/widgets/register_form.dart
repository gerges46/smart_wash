import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
class RegisterForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController; // ← جديد
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController, // ← جديد
    required this.passwordController,
    required this.confirmPasswordController,
  });

  Widget _buildTextField(
    String hint,
    IconData icon, {
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: hint.contains("رقم") ? TextInputType.phone : TextInputType.text,
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
        _buildTextField("الاسم الكامل", Icons.person_outline, controller: nameController),
        SizedBox(height: 16.h),
        _buildTextField("رقم الموبايل", Icons.phone_outlined, controller: phoneController), // ← جديد
        SizedBox(height: 16.h),
        _buildTextField("البريد الإلكتروني", Icons.email_outlined, controller: emailController),
        SizedBox(height: 16.h),
        _buildTextField("كلمة المرور", Icons.lock_outline, isPassword: true, controller: passwordController),
        SizedBox(height: 16.h),
        _buildTextField("تأكيد كلمة المرور", Icons.lock_outline, isPassword: true, controller: confirmPasswordController),
      ],
    );
  }
}
