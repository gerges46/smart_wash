import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/features/user/booking/new_booking_view/widgets/custom_card.dart';
class BookingForm extends StatelessWidget {
  final String? service;
  final double? price; // ✅ السعر الجديد
  final DateTime? date;
  final TimeOfDay? time;
  final Function(String?) onServiceChange;
  final VoidCallback onPickDate;
  final VoidCallback onPickTime;
  final Function(String) onAddressChange;

  const BookingForm({
    super.key,
    required this.service,
    required this.price, // ✅
    required this.date,
    required this.time,
    required this.onServiceChange,
    required this.onPickDate,
    required this.onPickTime,
    required this.onAddressChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// ------------------ Service ------------------
        CustomCard(
          child: Row(
            children: [
              const Icon(Icons.cleaning_services, color: AppColors.primary),
              SizedBox(width: AppSize.s16.w),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: service,
                  items: AppStrings.services
                      .map(
                        (s) => DropdownMenuItem(
                          value: s,
                          child: Text(
                            s,
                            style: const TextStyle(
                              fontSize: AppSize.s16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: onServiceChange,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: AppStrings.selectService,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// ------------------ Price ------------------
        if (price != null)
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "السعر: ${price!.toStringAsFixed(2)} ريال 💰", // ✅ عرض السعر بالريال
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),

        SizedBox(height: AppMargin.m16.h),

        /// ------------------ Date & Time ------------------
        CustomCard(
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onPickDate,
                  icon: const Icon(Icons.calendar_today, color: AppColors.primary),
                  label: Text(
                    date == null
                        ? AppStrings.selectDate
                        : "${date!.day}/${date!.month}/${date!.year}",
                    style: const TextStyle(
                      fontSize: AppSize.s16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: AppSize.s12.w),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onPickTime,
                  icon: const Icon(Icons.access_time, color: AppColors.primary),
                  label: Text(
                    time == null ? AppStrings.selectTime : time!.format(context),
                    style: const TextStyle(
                      fontSize: AppSize.s16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: AppMargin.m16.h),

        /// ------------------ Address ------------------
        CustomCard(
          child: Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.primary),
              SizedBox(width: AppSize.s16.w),
              Expanded(
                child: TextField(
                  onChanged: onAddressChange,
                  style: const TextStyle(
                    fontSize: AppSize.s16,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: AppStrings.selectAddress,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
