import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/routes/app_router.dart';
import 'package:smart_clean/features/user/booking/booking_details/cubit/booking_details_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      providers: [BlocProvider(create: (_) => BookingDetailsCubit())],
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
