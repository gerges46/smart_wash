import 'package:flutter/material.dart';
import 'package:smart_clean/core/constants/app_color.dart';

void showEditOrderDialog({
  required BuildContext context,
  required String currentService,
  required String currentTime,
  required String currentLocation,
  required String currentStatus,
  required List<String> servicesList,
  required List<String> statusList,
  required Function(String, String, String, String, double) onSave,
  double? currentPrice,
}) {
  final locationController = TextEditingController(text: currentLocation);
  final priceController =
      TextEditingController(text: currentPrice?.toString() ?? "0");

  WidgetsBinding.instance.addPostFrameCallback((_) {
    locationController.selection = TextSelection.fromPosition(
      TextPosition(offset: locationController.text.length),
    );
  });

  String newService = currentService;
  String newTime = currentTime;
  String newStatus = currentStatus;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: Colors.white,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          titlePadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          contentPadding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
          title: Row(
            children: [
              const Icon(Icons.edit_note, color: AppColors.primary, size: 28),
              const SizedBox(width: 10),
              const Text(
                "تعديل الطلب",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 اختيار الخدمة
                Text(
                  "الخدمة",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: servicesList.contains(newService)
                      ? newService
                      : servicesList.first,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  items: servicesList
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) => setState(() => newService = v!),
                ),
                const SizedBox(height: 14),

                /// 🔹 السعر
                Text(
                  "السعر (ج.م)",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "اكتب السعر هنا",
                    prefixIcon: const Icon(Icons.attach_money,
                        color: AppColors.primary),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                /// 🔹 الوقت
                Text(
                  "الوقت",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () async {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        newTime = pickedTime.format(context);
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time_filled,
                            color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          newTime.isEmpty ? "اختر الوقت" : newTime,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                /// 🔹 الموقع
                Text(
                  "الموقع",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    hintText: "اكتب موقع العميل هنا...",
                    prefixIcon:
                        const Icon(Icons.location_on, color: AppColors.primary),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                /// 🔹 الحالة
                Text(
                  "الحالة",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: statusList.contains(newStatus)
                      ? newStatus
                      : statusList.first,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  items: statusList
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) => setState(() => newStatus = v!),
                ),
              ],
            ),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "إلغاء",
                style: TextStyle(color: AppColors.primary),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                final double parsedPrice =
                    double.tryParse(priceController.text) ?? 0;
                onSave(
                  newService,
                  newTime,
                  locationController.text,
                  newStatus,
                  parsedPrice,
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              ),
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text(
                "حفظ التعديلات",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
