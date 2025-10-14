import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class ServiceCard extends StatelessWidget {
  final Color color;
  final Color iconColor;
  final String title;
  final String price;

  const ServiceCard({
    super.key,
    required this.color,
    required this.iconColor,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppSize.s16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppPadding.p16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 55.w,
              width: 55.w,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(
                Icons.directions_car_outlined,
                color: iconColor,
                size: 28.w,
              ),
            ),
            SizedBox(height: AppSize.s12.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: AppColor.textPrimary,
              ),
            ),
            SizedBox(height: AppSize.s4.h),
            Text(
              price,
              style: TextStyle(fontSize: 13.sp, color: AppColor.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
