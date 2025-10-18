import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteField extends StatelessWidget {
  final TextEditingController controller;
  const NoteField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.w),
      child: TextField(
        controller: controller,
        maxLines: 5,
        decoration: const InputDecoration(
          hintText: "اكتب ملاحظاتك هنا...",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
