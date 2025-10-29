import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value; // ✅ يقبل null بأمان
  final Color? valueColor; // ✅ لون مخصص لقيمة النص (اختياري)

  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.valueColor, // ✅ تمت الإضافة
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 22.sp),
        SizedBox(width: 10.w),
        Text(
          title,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value ?? "غير محدد", // ✅ يمنع الخطأ لو null
          style: TextStyle(
            color: valueColor ?? Colors.black, // ✅ لو فيه لون نستخدمه
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
