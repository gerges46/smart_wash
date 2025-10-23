import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';

class OrderItemTile extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderItemTile({super.key, required this.order});

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Completed":
        return Icons.check_circle_rounded;
      case "Pending":
        return Icons.access_time_rounded;
      case "Canceled":
        return Icons.cancel_rounded;
      default:
        return Icons.info_outline_rounded;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      case "Canceled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildInfoRow(IconData icon, String label, String value,
      {Color? color}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color ?? Colors.grey[700]),
          SizedBox(width: 6.w),
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
              fontSize: 13.5.sp,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 13.5.sp,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final status = order["status"] ?? "Unknown";
    final color = _getStatusColor(status);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 اسم المستخدم
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order["userName"] ?? "Unknown User",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: AppColors.primary,
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(_getStatusIcon(status), color: color, size: 16),
                    SizedBox(width: 5.w),
                    Text(
                      status,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),
          Divider(color: Colors.grey.shade300, height: 12.h),

          // 🔹 تفاصيل الحجز
          _buildInfoRow(Icons.cleaning_services_rounded, "Service",
              order["service"] ?? "N/A"),
          _buildInfoRow(Icons.attach_money_rounded, "Price",
              "${order["price"] ?? '0'} EGP"),
          _buildInfoRow(Icons.schedule_rounded, "Time",
              order["time"] ?? "Not specified"),
          _buildInfoRow(Icons.location_on_rounded, "Address",
              order["address"] ?? "No address"),

          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
