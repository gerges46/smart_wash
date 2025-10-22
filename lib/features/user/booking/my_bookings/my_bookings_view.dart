import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/features/user/booking/new_booking_view/cubit/booking_cubit.dart';
import 'widgets/bookings_list.dart';
import 'widgets/bookings_header.dart';

class MyBookingsView extends StatefulWidget {
  const MyBookingsView({super.key});

  @override
  State<MyBookingsView> createState() => _MyBookingsViewState();
}

class _MyBookingsViewState extends State<MyBookingsView> {
  @override
  void initState() {
    super.initState();
    // ✅ نجيب الحجوزات مرة واحدة عند فتح الصفحة
    context.read<BookingCubit>().getUserBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const BookingsHeader(),
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.myBookingsSubtitle,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: AppSize.s16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppSize.s16.h),
            Expanded(
              child: BlocBuilder<BookingCubit, BookingState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.userBookings.isEmpty) {
                    return const Center(
                      child: Text("لا توجد حجوزات حالياً 😔"),
                    );
                  }

                  return BookingsList(bookings: state.userBookings);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

