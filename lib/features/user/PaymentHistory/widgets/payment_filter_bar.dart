import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';

class PaymentFilterBar extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const PaymentFilterBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = ["الكل", "مدفوعة", "غير مدفوعة"];

    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: filters.map((label) {
          final isSelected = selectedFilter == label;
          return ElevatedButton(
            onPressed: () => onFilterChanged(label),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isSelected ? AppColors.primary : Colors.grey.shade300,
              foregroundColor: isSelected ? Colors.white : Colors.black,
            ),
            child: Text(label),
          );
        }).toList(),
      ),
    );
  }
}
