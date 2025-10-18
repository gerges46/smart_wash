import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class WhyUsSection extends StatelessWidget {
  const WhyUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.whyUs,
          style: TextStyle(
            fontSize: AppSize.s18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppSize.s12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _WhyCard(
              icon: Icons.timer,
              title: AppStrings.fast,
              subtitle: AppStrings.onTime,
            ),
            _WhyCard(
              icon: Icons.thumb_up,
              title: AppStrings.trusted,
              subtitle: AppStrings.proTeam,
            ),
            _WhyCard(
              icon: Icons.attach_money,
              title: AppStrings.affordable,
              subtitle: AppStrings.goodValue,
            ),
          ],
        ),
      ],
    );
  }
}

class _WhyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _WhyCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppPadding.p12.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSize.s12.r),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primary, size: AppSize.s28.sp),
            SizedBox(height: AppSize.s8.h),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: AppSize.s12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
