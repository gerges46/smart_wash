import 'package:flutter/material.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/routes/app_router.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppStrings.noAccount, style: TextStyle(color: AppColors.grey)),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.registerRoute);
          },
          child: Text(
            AppStrings.createAccount,
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
