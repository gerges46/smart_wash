import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'order_item_tile.dart';

class DayScheduleTile extends StatelessWidget {
  final String day;
  final List<Map<String, dynamic>> orders;

  const DayScheduleTile({super.key, required this.day, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ExpansionTile(
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
        title: Text(
          day,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
            color: AppColors.primary,
          ),
        ),
        subtitle: Text(
          "${orders.length} Booking${orders.length > 1 ? 's' : ''}",
          style: TextStyle(color: Colors.grey[600], fontSize: 13.sp),
        ),
        childrenPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        children: [
          ...orders.map((order) => OrderItemTile(order: order)),
          if (orders.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 1,
                indent: 16.w,
                endIndent: 16.w,
              ),
            ),
        ],
      ),
    );
  }
}
