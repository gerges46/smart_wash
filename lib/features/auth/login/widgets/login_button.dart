import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/routes/app_router.dart';
import 'package:smart_clean/features/auth/cubit/auth_cubit.dart';
import 'package:smart_clean/features/auth/cubit/auth_state.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
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
                ? "تم تسجيل دخول كادمن بنجاح!"
                : "تم تسجيل الدخول بنجاح!",
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
            animType: AnimType.rightSlide,
            title: 'فشل تسجيل الدخول',
            desc: state.message,
            btnOkText: "حسنًا",
            btnOkOnPress: () {},
          ).show();
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: state is AuthLoading
                ? null
                : () {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: 'تنبيه',
                        desc: 'من فضلك أدخل البريد وكلمة المرور',
                        btnOkText: "حسنًا",
                        btnOkOnPress: () {},
                      ).show();
                      return;
                    }

                    context.read<AuthCubit>().loginUser(
                      email: email,
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
                    AppStrings.loginButton,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
