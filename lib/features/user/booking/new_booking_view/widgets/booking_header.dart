import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

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
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back,
          color: AppColors.primary,
          size: AppSize.s22.sp,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
