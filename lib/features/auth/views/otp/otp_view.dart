import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/features/auth/cubit/otp/otp_cubit.dart';
import 'package:smart_clean/features/auth/cubit/otp/otp_state.dart';
import 'widgets/otp_header.dart';
import 'widgets/otp_input_fields.dart';
import 'widgets/otp_timer.dart';

class OTPView extends StatelessWidget {
  OTPView({super.key});

  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OTPCubit()..startTimer(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const OTPHeader(),
                SizedBox(height: AppSize.s40.h),

                // حقل الإدخال
                OTPInputFields(controller: _otpController),

                SizedBox(height: AppSize.s30.h),

                // المؤقت
                BlocBuilder<OTPCubit, OTPState>(
                  builder: (context, state) {
                    if (state is OTPTimerRunning) {
                      return OTPTimer(
                        seconds: state.seconds,
                        canResend: false,
                        onResend: () {},
                      );
                    } else if (state is OTPCanResend) {
                      return OTPTimer(
                        seconds: 0,
                        canResend: true,
                        onResend: () => context.read<OTPCubit>().resendCode(),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                SizedBox(height: AppSize.s40.h),

                // زر التحقق
                BlocConsumer<OTPCubit, OTPState>(
                  listener: (context, state) {
                    if (state is OTPVerified) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("✅ تم التحقق بنجاح")),
                      );
                    } else if (state is OTPError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is OTPVerifying;
                    return ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              final code = _otpController.text.trim();
                              context.read<OTPCubit>().verifyCode(code);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(
                          horizontal: 60.w,
                          vertical: 14.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: AppColors.white,
                            )
                          : Text(
                              AppStrings.verifyNow,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: AppSize.s18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
