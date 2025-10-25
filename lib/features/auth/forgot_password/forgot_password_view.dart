import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/features/auth/cubit/auth_cubit.dart';
import 'package:smart_clean/features/auth/cubit/auth_state.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.primary),
        title: const Text(
          "Forgot Password",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 40.h),
                Icon(Icons.lock_reset_rounded,
                    size: 80.sp, color: AppColors.primary),
                SizedBox(height: 20.h),
                Text(
                  "Reset your password",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Enter your email address and we’ll send you a link to reset your password.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.lightText,
                  ),
                ),
                SizedBox(height: 40.h),

                /// 🔹 Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.fieldBackground,
                    hintText: "Enter your email",
                    hintStyle: TextStyle(color: AppColors.greyText),
                    prefixIcon: const Icon(Icons.email_outlined,
                        color: AppColors.primary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                          color: AppColors.primary, width: 1.5),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.h),

                /// 🔹 Reset Button via Cubit
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthPasswordResetEmailSentSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppColors.success,
                            content: Text(
                              "✅ Password reset link sent to your email.",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      } else if (state is AuthPasswordResetEmailSentFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.error,
                            content: Text(
                              state.message,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is AuthPasswordResetEmailSentLoading;
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<AuthCubit>()
                                      .resetPassword(_emailController.text.trim());
                                }
                              },
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                "Send Reset Link",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),

                /// 🔹 Back to Login
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Back to Login",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
