import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/features/user/profile/cubit/profile_cubit.dart';
import 'package:smart_clean/features/user/settings/save_button.dart';
import 'package:smart_clean/features/user/settings/settings_input_field.dart';

class SettingsForm extends StatefulWidget {
  final ProfileState state;
  const SettingsForm({super.key, required this.state});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _currentPasswordController = TextEditingController();

  @override
  void didUpdateWidget(covariant SettingsForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state is ProfileLoaded) {
      final data = widget.state as ProfileLoaded;
      _phoneController.text = data.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    return Form(
      key: _formKey,
      child: Card(
        elevation: 4,
        shadowColor: AppColors.primary.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              SettingsInputField(
                controller: _phoneController,
                label: "رقم الموبايل",
                icon: Icons.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'أدخل رقم الموبايل';
                  if (value.length < 10) return 'رقم غير صالح';
                  return null;
                },
              ),
              SizedBox(height: 15.h),
              SettingsInputField(
                controller: _currentPasswordController,
                label: "كلمة المرور الحالية",
                icon: Icons.lock_outline,
                obscure: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'أدخل كلمة المرور الحالية';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.h),
              SettingsInputField(
                controller: _passwordController,
                label: "كلمة المرور الجديدة (اختياري)",
                icon: Icons.lock,
                obscure: true,
              ),
              SizedBox(height: 30.h),
              SaveButton(
                isLoading: state is ProfileLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<ProfileCubit>().updateUserData(
                          phone: _phoneController.text,
                          currentPassword: _currentPasswordController.text,
                          newPassword: _passwordController.text,
                        );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
