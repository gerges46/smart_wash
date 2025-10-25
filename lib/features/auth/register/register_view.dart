import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/features/auth/register/widgets/register_button.dart';
import 'package:smart_clean/features/auth/register/widgets/register_form.dart';
import 'package:smart_clean/features/auth/register/widgets/register_header.dart';

// ✅ RegisterView
class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(); // ← جديد
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const RegisterHeader(),
              SizedBox(height: 32.h),

              RegisterForm(
                nameController: nameController,
                emailController: emailController,
                phoneController: phoneController, // ← أضفنا هنا
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              ),

              SizedBox(height: 24.h),

              RegisterButton(
                nameController: nameController,
                emailController: emailController,
                phoneController: phoneController, // ← وأضفنا هنا كمان
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


