import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/features/auth/register/widgets/register_button.dart';
import 'package:smart_clean/features/auth/register/widgets/register_form.dart';
import 'package:smart_clean/features/auth/register/widgets/register_header.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  // 🔹 تعريف controllers هنا فقط
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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

              // 🔸 نمرر controllers للفورم
              RegisterForm(
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              ),

              SizedBox(height: 24.h),

              // 🔸 ونمرر نفس controllers للزرار
              RegisterButton(
                nameController: nameController,
                emailController: emailController,
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
