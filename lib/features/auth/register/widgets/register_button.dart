import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/routes/app_router.dart';
import 'package:smart_clean/features/auth/cubit/auth_cubit.dart';
import 'package:smart_clean/features/auth/cubit/auth_state.dart';

class RegisterButton extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController; // ← جديد
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterButton({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController, // ← جديد
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            title: "تم بنجاح 🎉",
            desc: state.isAdmin
                ? "تم تسجيل دخول الأدمن بنجاح!"
                : "تم إنشاء الحساب بنجاح!",
            btnOkText: "متابعة",
            btnOkOnPress: () {
              if (state.isAdmin) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.adminDashboard,
                  (route) => false,
                );
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.bottomNavRoute,
                  (route) => false,
                );
              }
            },
          ).show();
        } else if (state is AuthFailure) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: "حدث خطأ 😕",
            desc: state.message,
            btnOkText: "حسناً",
            btnOkOnPress: () {},
          ).show();
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: state is AuthLoading
                    ? null
                    : () {
                        final name = nameController.text.trim();
                        final email = emailController.text.trim();
                        final phone = phoneController.text.trim();
                        final password = passwordController.text.trim();
                        final confirmPassword =
                            confirmPasswordController.text.trim();

                        // ✅ التحقق من الحقول الفارغة
                        if (name.isEmpty ||
                            email.isEmpty ||
                            phone.isEmpty ||
                            password.isEmpty ||
                            confirmPassword.isEmpty) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.scale,
                            title: "تنبيه ⚠️",
                            desc: "من فضلك املأ جميع الحقول قبل المتابعة.",
                            btnOkText: "حسناً",
                            btnOkOnPress: () {},
                          ).show();
                          return;
                        }

                        // ✅ التحقق من تنسيق رقم الهاتف
                        final phoneRegex = RegExp(r'^[0-9]{10,11}$');
                        if (!phoneRegex.hasMatch(phone)) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.scale,
                            title: "رقم الهاتف غير صالح 📱",
                            desc:
                                "من فضلك أدخل رقم هاتف صحيح مكون من 10 أو 11 رقم.",
                            btnOkText: "حسناً",
                            btnOkOnPress: () {},
                          ).show();
                          return;
                        }

                        // ✅ التحقق من تطابق كلمتي المرور
                        if (password != confirmPassword) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.scale,
                            title: "كلمة المرور غير متطابقة ❌",
                            desc: "تأكد من أن كلمتي المرور متطابقتان.",
                            btnOkText: "حسناً",
                            btnOkOnPress: () {},
                          ).show();
                          return;
                        }

                        // ✅ تنفيذ التسجيل
                        context.read<AuthCubit>().registerUser(
                              name: name,
                              email: email,
                              phone: phone,
                              password: password,
                            );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: state is AuthLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        AppStrings.registerButton,
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            // 🔹 النص أسفل الزر
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.haveAccount,
                  style: TextStyle(color: AppColors.greyText),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  child: Text(
                    AppStrings.loginNow,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
