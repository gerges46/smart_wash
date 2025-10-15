import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/features/auth/views/register/widgets/register_button.dart';
import 'package:smart_clean/features/auth/views/register/widgets/register_form.dart';
import 'package:smart_clean/features/auth/views/register/widgets/register_header.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
              const RegisterForm(),
              SizedBox(height: 24.h),
              const RegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}
