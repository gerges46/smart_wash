import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/core/routes/app_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
  // استنى 3 ثواني زي Splash
  await Future.delayed(const Duration(seconds: 3));

  if (!mounted) return;

  User? user = FirebaseAuth.instance.currentUser;
  print("Current user: $user");

  if (user == null) {
    // مفيش حد مسجل دخول
    Navigator.pushReplacementNamed(context, Routes.onboardingRoute);
    return;
  }

  try {
    // جلب بيانات المستخدم من Firestore
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!mounted) return;

    if (userDoc.exists) {
      // قراءة الدور بشكل آمن
      final role = userDoc.data()?['role']?.toString() ?? 'user';
      print("User role: $role");

      if (role == 'admin') {
        // الأدمن يدخل dashboard
        Navigator.pushReplacementNamed(context, Routes.adminDashboard);
      } else {
        // المستخدم العادي يدخل home
        Navigator.pushReplacementNamed(context, Routes.bottomNavRoute);
      }
    } else {
      // document مش موجود → onboarding
      Navigator.pushReplacementNamed(context, Routes.onboardingRoute);
    }
  } catch (e) {
    // أي خطأ → onboarding
    print("Error fetching userDoc: $e");
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, Routes.onboardingRoute);
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔹 شعار التطبيق
              // Image.asset(AppAssets.logo, width: AppSize.s120),
              SizedBox(height: AppMargin.m24),

              // 🔹 اسم التطبيق
              Text(
                AppStrings.appName,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: AppSize.s28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
