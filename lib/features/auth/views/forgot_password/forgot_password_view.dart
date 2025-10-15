// lib/features/auth/forgot_password/view/forgot_password_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/features/auth/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:smart_clean/features/auth/cubit/forgot_password/forgot_password_state.dart';
import 'package:smart_clean/features/auth/views/forgot_password/widgets/contact_form.dart';
import 'package:smart_clean/features/auth/views/forgot_password/widgets/forgot_header.dart';
import 'package:smart_clean/features/auth/views/forgot_password/widgets/forgot_timer.dart';
import 'package:smart_clean/features/auth/views/forgot_password/widgets/otp_fields.dart';
import 'package:smart_clean/features/auth/views/forgot_password/widgets/reset_form.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});
  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  int _step = 0; // 0: contact, 1: otp, 2: reset
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _goToStep(int s) => setState(() => _step = s);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotLoading) {
            // optional: show loading or let buttons show their own loading
          } else if (state is ForgotCodeSent) {
            _goToStep(1);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم إرسال رمز التحقق")),
            );
          } else if (state is ForgotCanResend) {
            // handled by builder
          } else if (state is ForgotVerified) {
            _goToStep(2);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم التحقق، أدخل كلمة مرور جديدة")),
            );
          } else if (state is ForgotSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            // after success, go back to login (or navigate)
            Navigator.pop(context);
          } else if (state is ForgotError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          // derive timer values
          int seconds = 0;
          bool canResend = false;
          if (state is ForgotTimerRunning) seconds = state.seconds;
          if (state is ForgotCanResend) canResend = true;

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: AppColors.primary),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p24.w,
                  vertical: AppPadding.p20.h,
                ),
                child: Column(
                  children: [
                    const ForgotHeader(),
                    SizedBox(height: AppSize.s24.h),

                    // stepper indicator simple
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (i) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 6.w),
                          width: _step == i ? 28.w : 12.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: _step == i
                                ? AppColors.primary
                                : AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: AppSize.s24.h),

                    // step content
                    if (_step == 0) ...[
                      ContactForm(
                        onSend: (contact) => context
                            .read<ForgotPasswordCubit>()
                            .sendCode(contact),
                      ),
                    ] else if (_step == 1) ...[
                      ForgotOTPFields(controller: _otpController),
                      SizedBox(height: AppSize.s20.h),
                      ForgotTimer(
                        seconds: seconds,
                        canResend: canResend,
                        onResend: () =>
                            context.read<ForgotPasswordCubit>().resendCode(),
                      ),
                      SizedBox(height: AppSize.s24.h),
                      ElevatedButton(
                        onPressed: () => context
                            .read<ForgotPasswordCubit>()
                            .verifyCode(_otpController.text.trim()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(
                            vertical: 14.h,
                            horizontal: 50.w,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                          ),
                        ),
                        child: state is ForgotVerifying
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                AppStrings.verifyNow,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: AppSize.s16.sp,
                                ),
                              ),
                      ),
                    ] else if (_step == 2) ...[
                      ResetForm(
                        onReset: (pass, confirm) => context
                            .read<ForgotPasswordCubit>()
                            .resetPassword(pass, confirm),
                      ),
                    ],

                    SizedBox(height: AppSize.s24.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
