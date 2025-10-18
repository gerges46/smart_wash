// lib/features/auth/forgot_password/widgets/contact_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class ContactForm extends StatefulWidget {
  final void Function(String contact) onSend;
  const ContactForm({super.key, required this.onSend});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _contactController = TextEditingController();

  @override
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _contactController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_outline, color: AppColors.primary),
            hintText: AppStrings.contactHint,
            filled: true,
            fillColor: AppColors.fieldBackground,
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
                onPressed: () => widget.onSend(_contactController.text.trim()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: Text(
                  AppStrings.sendCode,
                  style: TextStyle(
                    fontSize: AppSize.s16.sp,
                    color: AppColors.white,
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
