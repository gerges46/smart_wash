import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';

class ProfileCard extends StatelessWidget {
  final Map<String, String> user;

  const ProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45.r,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Icon(
              Icons.person,
              size: 50.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            user['name']!,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            user['phone']!,
            style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            user['email']!,
            style: TextStyle(color: Colors.grey[600], fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
