import 'package:flutter/material.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/features/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String homeRoute = "/home";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());

      // case Routes.loginRoute:
      //   return MaterialPageRoute(builder: (_) => const LoginView());
      // case Routes.registerRoute:
      //   return MaterialPageRoute(builder: (_) => const RegisterView());
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
