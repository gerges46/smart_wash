import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/routes/app_router.dart';
import 'package:smart_clean/features/user/booking/prebooking/widgets/booking_card.dart';
import 'package:smart_clean/features/user/booking/new_booking_view/cubit/booking_cubit.dart';

class PreBookingView extends StatelessWidget {
  const PreBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ استدعاء الدالة أول ما تفتح الشاشة
    context.read<BookingCubit>().getLastBooking();

    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 1,
            title: Text(
              AppStrings.lastBookingTitle,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: AppColors.primary),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.w),
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.lastBooking == null
                    ? Center(
                        child: Text(
                          "لا يوجد حجز حالي بعد.",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.darkGrey,
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.lastBookingDetails,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: 20.h),

                          /// 🔹 Card
                          BookingCard(lastBooking: state.lastBooking!),

                          const Spacer(),

                          /// 🔹 Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding:
                                    EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                elevation: 2,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.myBookingsRoute);
                              },
                              child: Text(
                                AppStrings.showBookings,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Center(
                            child: Text(
                              AppStrings.thankYou,
                              style: TextStyle(
                                color: AppColors.darkGrey,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
          ),
        );
      },
    );
  }
}
