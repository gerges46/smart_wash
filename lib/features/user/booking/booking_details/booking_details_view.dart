import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/core/routes/app_router.dart';
import 'package:smart_clean/core/utils/date_time_formatter.dart';
import 'package:smart_clean/features/user/booking/new_booking_view/cubit/booking_cubit.dart';
import 'package:smart_clean/features/user/booking/booking_details/widgets/booking_details_constants.dart';
import 'package:smart_clean/features/user/booking/booking_details/widgets/booking_detail_card.dart';
import 'package:smart_clean/features/user/booking/booking_details/widgets/booking_action_button.dart';

class BookingDetailsView extends StatefulWidget {
  const BookingDetailsView({super.key});

  @override
  State<BookingDetailsView> createState() => _BookingDetailsViewState();
}

class _BookingDetailsViewState extends State<BookingDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<BookingCubit>().getLastBooking(); // ✅ تحميل آخر حجز عند فتح الصفحة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.bookingDetailsTitle),
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.primary),
        elevation: 1,
        centerTitle: true,
      ),
      body: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          // 🔄 أثناء التحميل
          if (state.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text("جاري تحميل الحجز..."),
                ],
              ),
            );
          }

          // ❌ في حالة عدم وجود حجز
          if (state.lastBooking == null) {
            return const Center(
              child: Text(
                "⚠️ لا يوجد أي حجز حتى الآن.",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          // ✅ عرض بيانات آخر حجز
          final booking = state.lastBooking!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(AppPadding.p20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🟦 اسم الخدمة
                Text(
                  booking['service'] ?? AppStrings.undefinedService,
                  style: BookingDetailsStyles.title,
                ),
                SizedBox(height: AppSize.s12.h),

                // 🕒 الموعد (تنسيق التاريخ والوقت)
                  Text(
                    "${AppStrings.appointment}: ${formatDateTime(booking['date'], booking['time'])}",
                    style: BookingDetailsStyles.subtitle,
                  ),


                SizedBox(height: AppSize.s20.h),

                // 🧾 التفاصيل
                Row(
                  children: [
                    BookingDetailCard(
                      title: AppStrings.location,
                      value: booking['address'] ?? AppStrings.defaultLocation,
                    ),
                    SizedBox(width: AppMargin.m12.w),
                    BookingDetailCard(
                      title: AppStrings.price,
                      value: "${booking['price'] ?? AppStrings.defaultPrice} جنيه",
                    ),
                  ],
                ),
                SizedBox(height: AppSize.s30.h),

                
    // 🟢 نوع الخدمة وحالة الدفع
    Row(
      children: [
        BookingDetailCard(
          title: "نوع الخدمة",
          value: booking['service'] ?? "غير محدد",
        ),
        SizedBox(width: AppMargin.m12.w),
        BookingDetailCard(
          title: "حالة الدفع",
          value: (booking['isPaid'] == true)
              ? "✅ تم الدفع"
              : "💰 لم يتم الدفع",
        ),
      ],
    ),

     SizedBox(height: AppSize.s30.h),
                // 🔘 الأزرار
                Row(
                  children: [
                   BookingActionButton(
  text: AppStrings.cancelBooking,
  isPrimary: false,
  onTap: () async {
    await context.read<BookingCubit>().cancelBooking(context);
    
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pop(context); // إغلاق الـ Dialog
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.bottomNavRoute,
        (route) => false,
                );
                 },
                  ),
                    SizedBox(width: AppMargin.m12.w),
                    BookingActionButton(
                      text: AppStrings.rateService,
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.ratingRoute),
                    ),
                  ],
                ),
                
              ],
            ),
          );
        },
      ),
    );
  }
  
}
