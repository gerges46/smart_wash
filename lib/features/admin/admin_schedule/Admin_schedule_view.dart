import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class AdminScheduleView extends StatelessWidget {
  const AdminScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final schedule = [
      {
        "day": "Monday",
        "orders": [
          {"time": "09:00 AM", "service": "Full Wash", "status": "Completed"},
          {
            "time": "12:00 PM",
            "service": "Interior Cleaning",
            "status": "Pending",
          },
        ],
      },
      {
        "day": "Tuesday",
        "orders": [
          {"time": "10:30 AM", "service": "Exterior Wash", "status": "Pending"},
          {"time": "03:00 PM", "service": "Polish", "status": "Completed"},
        ],
      },
      {
        "day": "Wednesday",
        "orders": [
          {"time": "11:00 AM", "service": "Engine Wash", "status": "Pending"},
        ],
      },
      {
        "day": "Thursday",
        "orders": [
          {"time": "09:30 AM", "service": "Full Wash", "status": "Completed"},
          {
            "time": "01:00 PM",
            "service": "Interior Cleaning",
            "status": "Completed",
          },
        ],
      },
      {"day": "Friday", "orders": []},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.95),
                AppColors.secondary.withOpacity(0.85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 🔙 زر الرجوع
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),

                  // 🗓️ العنوان
                  Text(
                    AppStrings.workerSchedule,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  // أيقونة وهمية للموازنة (عشان التايتل يبقى في المنتصف)
                  Container(width: 40.w),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(AppPadding.p20.w),
        itemCount: schedule.length,
        itemBuilder: (context, index) {
          final day = schedule[index];
          final orders = day["orders"] as List;

          return Container(
            margin: EdgeInsets.only(bottom: 14.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSize.s16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ExpansionTile(
              iconColor: AppColors.primary,
              collapsedIconColor: AppColors.primary,
              title: Text(
                day["day"].toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: AppColors.primary,
                ),
              ),
              subtitle: Text(
                "${orders.length} Orders",
                style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
              ),
              leading: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: AppColors.primary,
                ),
              ),
              children: orders.isNotEmpty
                  ? orders.map((order) {
                      final status = order["status"];
                      final color = status == "Completed"
                          ? Colors.green
                          : status == "Pending"
                          ? Colors.orange
                          : Colors.grey;

                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 6.h,
                          horizontal: 12.w,
                        ),
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          border: Border.all(color: color.withOpacity(0.4)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order["service"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: AppColors.darkGrey,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  order["time"],
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 5.h,
                              ),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.circle, color: color, size: 10),
                                  SizedBox(width: 6.w),
                                  Text(
                                    order["status"],
                                    style: TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList()
                  : [
                      Padding(
                        padding: EdgeInsets.all(AppPadding.p12.w),
                        child: Text(
                          "No orders scheduled for this day.",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ],
            ),
          );
        },
      ),
    );
  }
}
