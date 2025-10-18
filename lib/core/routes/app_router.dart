import 'package:flutter/material.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/features/user/auth/views/forgot_password/forgot_password_view.dart';
import 'package:smart_clean/features/user/auth/views/login/login_view.dart';
import 'package:smart_clean/features/user/auth/views/otp/otp_view.dart';
import 'package:smart_clean/features/user/auth/views/register/register_view.dart';
import 'package:smart_clean/features/user/booking/booking_details/booking_details_view.dart';
import 'package:smart_clean/features/user/booking/my_bookings/my_bookings_view.dart';
import 'package:smart_clean/features/user/booking/new_booking_view/new_booking_view.dart';
import 'package:smart_clean/features/user/booking/payment/payment_view.dart';
import 'package:smart_clean/features/user/booking/prebooking/prebooking_view.dart';
import 'package:smart_clean/features/user/booking/rating_view/rating_view.dart';
import 'package:smart_clean/features/user/home/home_view.dart';
import 'package:smart_clean/features/user/onboarding/views/onboarding_view.dart';
import 'package:smart_clean/features/splash_view.dart';
import 'package:smart_clean/features/user/profile/profile_view.dart';
import 'package:smart_clean/features/user/widgets/bottom_nav_shell.dart';

class Routes {
  static const String splashRoute = "/splash";
  static const String onboardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String homeRoute = "/home";
  static const String otpRoute = "/otp";
  static const String forgotPasswordRoute = "/forgot-password";

  // 🧩 Routes for User Side
  static const String newBookingRoute = "/new-booking";
  static const String preBookingRoute = "/pre-booking";
  static const String paymentRoute = "/payment";
  static const String myBookingsRoute = "/my-bookings";
  static const String bookingDetailsRoute = "/booking-details";
  static const String ratingRoute = "/rating";
  static const String profileRoute = "/profile";
  static const String bottomNavRoute = "/bottomNavShell";
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

      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());

      // 🧩 User Screens
      case Routes.newBookingRoute:
        return MaterialPageRoute(builder: (_) => const NewBookingView());

      case Routes.preBookingRoute:
        return MaterialPageRoute(builder: (_) => const PreBookingView());

      case Routes.paymentRoute:
        return MaterialPageRoute(builder: (_) => const PaymentView());

      case Routes.myBookingsRoute:
        return MaterialPageRoute(builder: (_) => const MyBookingsView());

      case Routes.bookingDetailsRoute:
        return MaterialPageRoute(
          builder: (_) => BookingDetailsView(booking: {}),
        );

      case Routes.ratingRoute:
        return MaterialPageRoute(builder: (_) => const RatingView());

      case Routes.bottomNavRoute:
        return MaterialPageRoute(builder: (_) => const BottomNavShell());

      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileView());

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
