import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/core/routes/app_router.dart';
import 'package:smart_clean/features/auth/views/widgets/register/register_button.dart';
import 'package:smart_clean/features/auth/views/widgets/register/register_header.dart';
import 'package:smart_clean/features/auth/views/widgets/register/register_text_field.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p24.w,
            vertical: AppPadding.p32.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const RegisterHeader(),

              SizedBox(height: AppSize.s30.h),

              // 🧾 الحقول
              const RegisterTextField(
                label: AppStrings.fullName,
                hint: AppStrings.nameHint,
                keyboard: TextInputType.name,
                isNameField: true,
              ),
              SizedBox(height: AppSize.s18.h),

              const RegisterTextField(
                label: AppStrings.email,
                hint: AppStrings.emailHint,
                keyboard: TextInputType.emailAddress,
              ),
              SizedBox(height: AppSize.s18.h),

              const RegisterTextField(
                label: AppStrings.phone,
                hint: AppStrings.phoneHint,
                keyboard: TextInputType.phone,
              ),
              SizedBox(height: AppSize.s18.h),

              const RegisterTextField(
                label: AppStrings.password,
                hint: AppStrings.passwordHint,
                obscure: true,
              ),
              SizedBox(height: AppSize.s18.h),

              const RegisterTextField(
                label: AppStrings.confirmPassword,
                hint: AppStrings.passwordHint,
                obscure: true,
              ),

              SizedBox(height: AppSize.s30.h),

              const RegisterButton(),

              SizedBox(height: AppSize.s25.h),

              // 🔵 سجل دخولك
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.haveAccount,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColor.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.loginRoute,
                      );
                    },
                    child: Text(
                      AppStrings.loginNow,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
