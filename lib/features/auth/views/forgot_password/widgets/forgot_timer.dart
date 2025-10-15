// lib/features/auth/forgot_password/widgets/forgot_timer.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class ForgotTimer extends StatelessWidget {
  final int seconds;
  final bool canResend;
  final VoidCallback onResend;

  const ForgotTimer({
    super.key,
    required this.seconds,
    required this.canResend,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          canResend ? "لم تستلم الرمز؟" : "إعادة الإرسال خلال ${seconds}s",
          style: TextStyle(color: AppColors.grey, fontSize: AppSize.s14.sp),
        ),
        if (canResend)
          TextButton(
            onPressed: onResend,
            child: Text(
              "إعادة الإرسال",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
