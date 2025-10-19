import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/features/auth/cubit/auth_cubit.dart';
import 'package:smart_clean/features/auth/cubit/auth_state.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: AppStrings.loginEmail,
            labelStyle: TextStyle(color: AppColors.grey),
            prefixIcon: Icon(Icons.person_outline, color: AppColors.primary),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 20.h),

        // 👇 BlocBuilder للتحكم في إظهار / إخفاء الباسورد
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final cubit = context.read<AuthCubit>();

            return TextField(
              controller: passwordController,
              obscureText: !cubit.isPasswordVisible,
              decoration: InputDecoration(
                labelText: AppStrings.loginPassword,
                labelStyle: TextStyle(color: AppColors.grey),
                prefixIcon: Icon(Icons.lock_outline, color: AppColors.primary),
                suffixIcon: IconButton(
                  icon: Icon(
                    cubit.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.grey,
                  ),
                  onPressed: () {
                    cubit.togglePasswordVisibility();
                  },
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
