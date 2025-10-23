import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/routes/app_router.dart';
import 'package:smart_clean/features/admin/admin_orders_dashboard/cubit/dashboard_cubit.dart';
import 'package:smart_clean/features/admin/admin_schedule/cubit/admin_schedule_cubit.dart';
import 'package:smart_clean/features/auth/cubit/auth_cubit.dart';
import 'package:smart_clean/features/user/booking/new_booking_view/cubit/booking_cubit.dart';
import 'package:smart_clean/features/user/home/cubit/home_cubit.dart';
import 'package:smart_clean/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BookingCubit()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => DashboardCubit()),
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create:  (_) => AdminScheduleCubit()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Washer',
        locale: const Locale('ar', 'EG'), // اللغة العربية - مصر
        supportedLocales: const [Locale('ar', 'EG')],
        localizationsDelegates: const [
          // دي المسؤولة عن تعريب عناصر الواجهة مثل التاريخ والأزرار
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl, // 🔥 الاتجاه من اليمين لليسار
            child: child!,
          );
        },
        theme: ThemeData(
          fontFamily: 'Cairo', // خط عربي جميل لو عندك الخط ده في المشروع
        ),
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.adminDashboard,
      ),
    );
  }
}
