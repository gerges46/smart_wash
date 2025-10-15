// lib/features/auth/forgot_password/widgets/reset_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class ResetForm extends StatefulWidget {
  final void Function(String pass, String confirm) onReset;
  const ResetForm({super.key, required this.onReset});

  @override
  State<ResetForm> createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  bool _showPass = false;
  bool _showConfirm = false;

  @override
  void dispose() {
    _pass.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _pass,
          obscureText: !_showPass,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline, color: AppColors.primary),
            hintText: AppStrings.newPasswordHint,
            filled: true,
            fillColor: AppColors.fieldBackground,
            suffixIcon: IconButton(
              icon: Icon(
                _showPass ? Icons.visibility : Icons.visibility_off,
                color: AppColors.grey,
              ),
              onPressed: () => setState(() => _showPass = !_showPass),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: AppSize.s16.h),
        TextField(
          controller: _confirm,
          obscureText: !_showConfirm,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline, color: AppColors.primary),
            hintText: AppStrings.confirmPassword,
            filled: true,
            fillColor: AppColors.fieldBackground,
            suffixIcon: IconButton(
              icon: Icon(
                _showConfirm ? Icons.visibility : Icons.visibility_off,
                color: AppColors.grey,
              ),
              onPressed: () => setState(() => _showConfirm = !_showConfirm),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: AppSize.s20.h),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () =>
                    widget.onReset(_pass.text.trim(), _confirm.text.trim()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: Text(
                  AppStrings.resetPasswordButton,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: AppSize.s16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
