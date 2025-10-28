import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';

class PaymentItemCard extends StatelessWidget {
  final Map<String, dynamic> payment;

  const PaymentItemCard({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    final isPaid = payment["status"] == "مدفوعة";

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                payment["service"] ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: AppColors.primary,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isPaid ? Colors.green.shade100 : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  payment["status"] ?? "",
                  style: TextStyle(
                    color: isPaid ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text("رقم الفاتورة: ${payment["id"] ?? ""}"),
          Text("تاريخ الدفع: ${payment["date"] ?? ""}"),
          Text("طريقة الدفع: ${payment["method"] ?? ""}"),
          SizedBox(height: 6.h),
          Text(
            "المبلغ: ${payment["amount"] ?? 0} ج.م",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
