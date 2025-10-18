import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/core/routes/app_router.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        "client": "Ahmed Hassan",
        "service": "Full Wash",
        "time": "10:00 AM",
        "status": "Pending",
      },
      {
        "client": "Omar Ali",
        "service": "Interior Cleaning",
        "time": "12:30 PM",
        "status": "In Progress",
      },
      {
        "client": "Sara Mohamed",
        "service": "Polish & Shine",
        "time": "04:00 PM",
        "status": "Completed",
      },
    ];

    Color getStatusColor(String status) {
      switch (status) {
        case "Completed":
          return Colors.green;
        case "In Progress":
          return Colors.orange;
        default:
          return Colors.grey;
      }
    }

    IconData getStatusIcon(String status) {
      switch (status) {
        case "Completed":
          return Icons.check_circle;
        case "In Progress":
          return Icons.work_history_rounded;
        default:
          return Icons.pending_actions;
      }
    }

    final completedCount = orders
        .where((e) => e["status"] == "Completed")
        .length;
    final pendingCount = orders.where((e) => e["status"] == "Pending").length;

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
                  // 👋 Title + Greeting
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22.r,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: Icon(
                          Icons.dashboard,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Smart Clean",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 13.sp,
                            ),
                          ),
                          Text(
                            AppStrings.ordersDashboard,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // 📅 Calendar Button
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.adminSchedule);
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // 📊 Dashboard Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            margin: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.9),
                  AppColors.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatItem("Total", orders.length.toString(), Colors.white),
                _buildStatItem(
                  "Completed",
                  completedCount.toString(),
                  Colors.white,
                ),
                _buildStatItem(
                  "Pending",
                  pendingCount.toString(),
                  Colors.white,
                ),
              ],
            ),
          ),

          // 📋 Orders List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final status = order["status"]!;
                final statusColor = getStatusColor(status);
                final statusIcon = getStatusIcon(status);

                return InkWell(
                  borderRadius: BorderRadius.circular(AppSize.s16),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.adminOrderDetails,
                      arguments: order,
                    );
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
                          child: Icon(
                            statusIcon,
                            color: statusColor,
                            size: 24.sp,
                          ),
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
                          padding: EdgeInsets.symmetric(
                            vertical: 6.h,
                            horizontal: 12.w,
                          ),
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
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.pushNamed(context, Routes.adminSchedule);
        },
        icon: const Icon(Icons.schedule, color: AppColors.white),
        label: const Text(
          "View Schedule",
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          title,
          style: TextStyle(color: color.withOpacity(0.9), fontSize: 13.sp),
        ),
      ],
    );
  }
}
