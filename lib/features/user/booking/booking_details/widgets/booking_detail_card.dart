import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/features/user/booking/booking_details/widgets/booking_details_constants.dart';

class BookingDetailCard extends StatelessWidget {
  final String title;
  final String value;

  const BookingDetailCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(AppPadding.p16.w),
        decoration: BookingDetailsStyles.cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: BookingDetailsStyles.detailTitle),
            SizedBox(height: AppSize.s6.h),
            Text(value, style: BookingDetailsStyles.detailValue),
          ],
        ),
      ),
    );
  }
}
