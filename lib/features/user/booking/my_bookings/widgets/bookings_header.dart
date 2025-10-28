import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/core/routes/app_router.dart';

class BookingsHeader extends StatelessWidget implements PreferredSizeWidget {
  const BookingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.primary),
      title: Text(
        AppStrings.myBookingsTitle,
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: AppSize.s18.sp,
        ),
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () {
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
  Size get preferredSize => Size.fromHeight(AppSize.s60.h);
}
