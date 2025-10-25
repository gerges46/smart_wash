import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/features/auth/forgot_password/forgot_password_view.dart';
import 'widgets/login_header.dart';
import 'widgets/login_form.dart';
import 'widgets/login_button.dart';
import 'widgets/login_footer.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40.h),
                const LoginHeader(),
                SizedBox(height: 32.h),
                LoginForm(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                SizedBox(height: 10.h),
                LoginButton(
                  emailController: emailController,
                  passwordController: passwordController,
                ),

                // ✅ النص اللي تحت الزرار
                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetPasswordView(),
                      ),
                    );
                  },
                  child: Text(
                    "نسيت كلمة المرور؟",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
                const LoginFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
