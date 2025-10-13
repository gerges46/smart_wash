import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smart_clean/core/routes/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Clean',
    debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      // the intial route will be the splash screen
      initialRoute: Routes.loginRoute,
      locale: const Locale('ar'), // اللغة الافتراضية 
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
