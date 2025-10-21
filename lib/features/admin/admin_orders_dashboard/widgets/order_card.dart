import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/core/routes/app_router.dart';
import 'package:smart_clean/features/admin/admin_orders_dashboard/widgets/admin_dashboard_helper.dart';

class OrderCard extends StatelessWidget {
  final Map<String, String> order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final status = order["status"]!;
    final statusColor = AdminDashboardHelper.getStatusColor(status);
    final statusIcon = AdminDashboardHelper.getStatusIcon(status);

    return InkWell(
      borderRadius: BorderRadius.circular(AppSize.s16),
      onTap: () {
        Navigator.pushNamed(context, Routes.adminOrderDetails, arguments: order);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSize.s16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26.r,
              backgroundColor: statusColor.withOpacity(0.15),
              child: Icon(statusIcon, color: statusColor, size: 24.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order["client"]!,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${order["service"]}  •  ${order["time"]}",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
