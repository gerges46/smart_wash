import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: AppSize.s100.h,),
          CircleAvatar(
            radius: AppSize.s60.r,
            backgroundColor: AppColor.circleAvatarIconColor,
            child: Icon(
              Icons.login_outlined,
              size: AppSize.s60.r,
              color: AppColor.loginButtonColor,
            ),
          ),
        ],
      ),
    );
  }
}