import 'package:flutter/material.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/features/auth/views/forgot_password/forgot_password_view.dart';
import 'package:smart_clean/features/auth/views/login/login_view.dart';
import 'package:smart_clean/features/auth/views/otp/otp_view.dart';
import 'package:smart_clean/features/auth/views/register/register_view.dart';
import 'package:smart_clean/features/onboarding/views/onboarding_view.dart';
import 'package:smart_clean/features/splash_view.dart';

class Routes {
  static const String splashRoute = "/splash";
  static const String onboardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String homeRoute = "/home";
  static const String otpRoute = "/otp";
  static const String forgotPasswordRoute = "/forgot-password";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());

      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.otpRoute:
        return MaterialPageRoute(builder: (_) => OTPView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      // case Routes.homeRoute:
      //   return MaterialPageRoute(builder: (_) => const HomeView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(AppStrings.noRouteFound)),
        body: Center(child: Text(AppStrings.noRouteFound)),
      ),
    );
  }
}
