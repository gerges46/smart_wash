import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/features/user/booking/new_booking_view/cubit/booking_cubit.dart';
import 'package:smart_clean/features/user/booking/new_booking_view/widgets/booking_confirm_button.dart';
import 'package:smart_clean/features/user/booking/new_booking_view/widgets/booking_form.dart';
import 'package:smart_clean/features/user/booking/new_booking_view/widgets/booking_header.dart';
import 'package:smart_clean/features/user/booking/payment/payment_view.dart';

class NewBookingView extends StatelessWidget {
  const NewBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        final cubit = context.read<BookingCubit>();

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BookingHeader(),
                  SizedBox(height: 24.h),
                  BookingForm(
                    service: state.service,
                    date: state.date,
                    time: state.time,
                    onServiceChange: cubit.changeService,
                    onPickDate: () => cubit.pickDate(context),
                    onPickTime: () => cubit.pickTime(context),
                    onAddressChange: cubit.changeAddress,
                  ),
                  SizedBox(height: 40.h),
                  BookingConfirmButton(
                    onConfirm: () {
                      if (cubit.validateData(context)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PaymentView(),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
