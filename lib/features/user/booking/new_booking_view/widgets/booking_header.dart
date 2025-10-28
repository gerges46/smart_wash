import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/core/routes/app_router.dart';

class BookingHeader extends StatelessWidget implements PreferredSizeWidget {
  const BookingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true, // 👈 يخلي العنوان في المنتصف
      title: Text(
        AppStrings.newBookingTitle,
        style: TextStyle(
          fontSize: AppSize.s22.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () {
            // الرجوع لشاشة الـ Home
            Navigator.pushNamedAndRemoveUntil(
              context, 
              Routes.bottomNavRoute, 
              (route) => false
            );
          },
        ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
