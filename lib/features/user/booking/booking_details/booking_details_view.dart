import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/core/routes/app_router.dart';
import 'package:smart_clean/features/user/booking/booking_details/widgets/booking_details_constants.dart';
import 'package:smart_clean/features/user/booking/booking_details/cubit/booking_details_cubit.dart';
import 'package:smart_clean/features/user/booking/booking_details/widgets/booking_detail_card.dart';
import 'package:smart_clean/features/user/booking/booking_details/widgets/booking_action_button.dart';

class BookingDetailsView extends StatelessWidget {
  final Map booking;
  const BookingDetailsView({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingDetailsCubit, BookingDetailsState>(
      listener: (context, state) {
        if (state is BookingCancelled) {
          Navigator.pushReplacementNamed(context, Routes.homeRoute);
        } else if (state is BookingRated) {
          Navigator.pushReplacementNamed(context, Routes.ratingRoute);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text(AppStrings.bookingDetailsTitle),
          backgroundColor: AppColors.white,
          iconTheme: IconThemeData(color: AppColors.primary),
          elevation: 1,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(AppPadding.p20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🟦 العنوان
              Text(
                booking['title'] ?? AppStrings.undefinedService,
                style: BookingDetailsStyles.title,
              ),
              SizedBox(height: AppSize.s12.h),

              // 🕒 الموعد
              Text(
                "${AppStrings.appointment}: ${booking['datetime'] ?? AppStrings.undefined}",
                style: BookingDetailsStyles.subtitle,
              ),
              SizedBox(height: AppSize.s20.h),

              // 🧾 التفاصيل
              Row(
                children: [
                  BookingDetailCard(
                    title: AppStrings.location,
                    value: booking['location'] ?? AppStrings.defaultLocation,
                  ),
                  SizedBox(width: AppMargin.m12.w),
                  BookingDetailCard(
                    title: AppStrings.price,
                    value: booking['price'] ?? AppStrings.defaultPrice,
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
                    onTap: () =>
                        context.read<BookingDetailsCubit>().cancelBooking(),
                  ),
                  SizedBox(width: AppMargin.m12.w),
                  BookingActionButton(
                    text: AppStrings.rateService,
                    onTap: () =>
                        context.read<BookingDetailsCubit>().rateBooking(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
