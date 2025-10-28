import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_clean/core/routes/app_router.dart';
import 'package:smart_clean/features/admin/admin_orders_dashboard/cubit/dashboard_cubit.dart';
import 'package:smart_clean/features/admin/admin_schedule/cubit/admin_schedule_cubit.dart';
import 'package:smart_clean/features/auth/cubit/auth_cubit.dart';
import 'package:smart_clean/features/user/booking/new_booking_view/cubit/booking_cubit.dart';
import 'package:smart_clean/features/user/home/cubit/home_cubit.dart';
import 'package:smart_clean/features/user/profile/cubit/profile_cubit.dart';
import 'package:smart_clean/firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// دالة بتشتغل لما يجيلك إشعار والتطبيق في الخلفية أو مقفول
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('📩 Received a background message: ${message.notification?.title}');
}

/// متغير عام للإشعارات المحلية
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 🕐 تهيئة المنطقة الزمنية
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

  // 🧩 تهيئة الإشعارات المحلية
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // 🔔 طلب إذن الإشعارات (خاصة لأندرويد 13 وأحدث)
  await _requestNotificationPermission();

  // 📲 إعداد Firebase Messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  print('🔔 Firebase permission: ${settings.authorizationStatus}');

  // 🔹 عرض الإشعارات عند استقبالها والتطبيق مفتوح
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('📥 Received message: ${message.notification?.title}');
    flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'default_channel',
          'General Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  });

  // 🔑 طباعة توكن المستخدم
  String? token = await messaging.getToken();
  print('🔑 User FCM Token: $token');

  // 🚀 تشغيل التطبيق
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => const MyApp(),
    ),
  );

  // // 🔔 اختبار إشعار فوري محلي بعد التشغيل
  // await flutterLocalNotificationsPlugin.show(
  //   0,
  //   'اختبار الإشعارات 🎯',
  //   'الإشعارات المحلية شغالة تمام ✅',
  //   const NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       'test_channel',
  //       'Test Notifications',
  //       importance: Importance.max,
  //       priority: Priority.high,
  //     ),
  //   ),
  // );
}

/// 🪄 طلب إذن الإشعارات في Android 13+
Future<void> _requestNotificationPermission() async {
  final status = await Permission.notification.status;
  if (status.isDenied || status.isRestricted) {
    final result = await Permission.notification.request();
    print('📱 Notification permission result: $result');
  }
}

/// تطبيقك الأساسي
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
        BlocProvider(create: (_) => AdminScheduleCubit()),
        BlocProvider(create: (_) => ProfileCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Washer',
        locale: const Locale('ar', 'EG'),
        supportedLocales: const [Locale('ar', 'EG')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },
        theme: ThemeData(
          fontFamily: 'Cairo',
        ),
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
      ),
    );
  }
}
