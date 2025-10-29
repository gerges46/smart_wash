import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/features/user/booking/new_booking_view/widgets/custom_card.dart';

class BookingForm extends StatelessWidget {
  final String? service;
  final double? price;
  final DateTime? date;
  final TimeOfDay? time;
  final Function(String?) onServiceChange;
  final VoidCallback onPickDate;
  final VoidCallback onPickTime;
  final Function(String) onAddressChange;

  const BookingForm({
    super.key,
    required this.service,
    required this.price,
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
        /// ------------------ Service Dropdown ------------------
        CustomCard(
          child: Row(
            children: [
              const Icon(Icons.cleaning_services, color: AppColors.primary),
              SizedBox(width: AppSize.s16.w),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: DropdownButtonFormField<String>(
                    value: service,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: AppStrings.selectService,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    icon: const Icon(Icons.arrow_drop_down_circle,
                        color: AppColors.primary),
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    items: AppStrings.services
                        .map(
                          (s) => DropdownMenuItem(
                            value: s,
                            child: Row(
                              children: [
                                const Icon(Icons.cleaning_services,
                                    color: AppColors.primary, size: 18),
                                SizedBox(width: 8.w),
                                Text(
                                  s,
                                  style: const TextStyle(
                                    fontSize: AppSize.s16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: onServiceChange,
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
                "السعر: ${price!.toStringAsFixed(2)} ريال 💰",
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
                child: _buildButton(
                  context,
                  icon: Icons.calendar_today,
                  label: date == null
                      ? AppStrings.selectDate
                      : "${date!.day}/${date!.month}/${date!.year}",
                  onPressed: onPickDate,
                ),
              ),
              SizedBox(width: AppSize.s12.w),
              Expanded(
                child: _buildButton(
                  context,
                  icon: Icons.access_time,
                  label: time == null
                      ? AppStrings.selectTime
                      : time!.format(context),
                  onPressed: onPickTime,
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

  /// 🔹 Custom Outlined Button for Date & Time
  Widget _buildButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white, size: 20),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: AppSize.s16,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
        elevation: 3,
      ),
    );
  }
}
