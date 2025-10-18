import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/features/user/booking/booking_details/widgets/booking_details_constants.dart';

class BookingActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isPrimary;

  const BookingActionButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppPadding.p16.h),
          decoration: BookingDetailsStyles.buttonDecoration(isPrimary),
          child: Center(
            child: Text(
              text,
              style: BookingDetailsStyles.buttonText.copyWith(
                color: isPrimary ? AppColors.white : AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
