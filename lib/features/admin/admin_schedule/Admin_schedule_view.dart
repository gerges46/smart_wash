import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'widgets/schedule_appbar.dart';
import 'widgets/day_schedule_tile.dart';
import 'cubit/admin_schedule_cubit.dart';
import 'cubit/admin_schedule_state.dart';

class AdminScheduleView extends StatefulWidget {
  const AdminScheduleView({super.key});

  @override
  State<AdminScheduleView> createState() => _AdminScheduleViewState();
}

class _AdminScheduleViewState extends State<AdminScheduleView> {
  late final AdminScheduleCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<AdminScheduleCubit>();
    cubit.fetchSchedule(); // استدعاء مرة واحدة فقط عند فتح الشاشة
  }

  /// 🔹 دالة لتحويل الوقت إلى رقم قابل للترتيب
  TimeOfDay _parseTime(dynamic timeString) {
    if (timeString == null || timeString.toString().isEmpty) {
      return const TimeOfDay(hour: 0, minute: 0);
    }

    try {
      final time = timeString.toString().toLowerCase().replaceAll(' ', '');
      final isPM = time.contains('pm');
      final clean = time.replaceAll('am', '').replaceAll('pm', '');
      final parts = clean.split(':');
      int hour = int.parse(parts[0]);
      int minute = parts.length > 1 ? int.parse(parts[1]) : 0;

      if (isPM && hour < 12) hour += 12;
      if (!isPM && hour == 12) hour = 0;

      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return const TimeOfDay(hour: 0, minute: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const ScheduleAppBar(),
      body: BlocBuilder<AdminScheduleCubit, AdminScheduleState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(
              child: Text(
                "❌ Error loading schedule: ${state.errorMessage}",
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (state.schedule.isEmpty) {
            return const Center(
              child: Text("No bookings found."),
            );
          }

          final schedule = state.schedule;

          // ✅ ترتيب الأيام حسب الأسبوع
          final orderedDays = [
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
            'Sunday',
          ].where((day) => schedule.keys.contains(day)).toList();

          return ListView.builder(
            padding: EdgeInsets.all(AppPadding.p20.w),
            itemCount: orderedDays.length,
            itemBuilder: (context, index) {
              final day = orderedDays[index];
              final orders = List<Map<String, dynamic>>.from(schedule[day]!);

              // 🔹 ترتيب الطلبات داخل اليوم حسب الوقت
              orders.sort((a, b) {
                final timeA = _parseTime(a['time']);
                final timeB = _parseTime(b['time']);
                return timeA.hour == timeB.hour
                    ? timeA.minute.compareTo(timeB.minute)
                    : timeA.hour.compareTo(timeB.hour);
              });

              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: DayScheduleTile(day: day, orders: orders),
              );
            },
          );
        },
      ),
    );
  }
}
