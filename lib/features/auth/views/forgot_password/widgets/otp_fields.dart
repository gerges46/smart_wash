// lib/features/auth/forgot_password/widgets/otp_fields.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class ForgotOTPFields extends StatefulWidget {
  final TextEditingController controller;
  const ForgotOTPFields({super.key, required this.controller});

  @override
  State<ForgotOTPFields> createState() => _ForgotOTPFieldsState();
}

class _ForgotOTPFieldsState extends State<ForgotOTPFields> {
  final List<FocusNode> _nodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      _controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final n in _nodes) n.dispose();
    super.dispose();
  }

  void _updateMainController() {
    widget.controller.text = _controllers.map((c) => c.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          width: 55.w,
          height: 55.w,
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(AppSize.s8.r),
            border: Border.all(color: AppColors.primary.withOpacity(0.4)),
          ),
          child: TextField(
            focusNode: _nodes[index],
            controller: _controllers[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(
              counterText: "",
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: AppSize.s20.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
            onChanged: (v) {
              _updateMainController();
              if (v.isNotEmpty) {
                if (index < 3) {
                  FocusScope.of(context).requestFocus(_nodes[index + 1]);
                } else {
                  _nodes[index].unfocus();
                }
              } else {
                if (index > 0) {
                  FocusScope.of(context).requestFocus(_nodes[index - 1]);
                }
              }
            },
          ),
        );
      }),
    );
  }
}
