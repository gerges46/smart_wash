import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/features/user/booking/payment/payment_constants.dart';

class PaymentOptionCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const PaymentOptionCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(vertical: AppMargin.m10.h),
        padding: EdgeInsets.all(AppPadding.p16.h),
        decoration: PaymentBoxDecorations.optionCard(selected),
        child: Row(
          children: [
            Icon(icon, color: selected ? AppColors.primary : AppColors.grey),
            SizedBox(width: AppSize.s16.w),
            Expanded(
              child: Text(title, style: PaymentTextStyles.option(selected)),
            ),
            if (selected) Icon(Icons.check_circle, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
