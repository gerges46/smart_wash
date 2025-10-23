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
  required Function(String, String, String, String) onSave,
}) {
  final locationController = TextEditingController(text: currentLocation);
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
    useRootNavigator: true, // ✅ أضف هذا السطر
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            "تعديل الطلب",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85, // ✅ لضبط عرض الحقول
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    value: servicesList.contains(newService)
                        ? newService
                        : servicesList.first,
                    decoration: const InputDecoration(
                      labelText: "الخدمة",
                      border: OutlineInputBorder(),
                    ),
                    items: servicesList
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) => setState(() => newService = v!),
                  ),
                  const SizedBox(height: 12),

                  /// ✅ اختيار الوقت وتحديثه فوريًا
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
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: double.infinity,
                      child: Text(
                        "الوقت: $newTime",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  /// ✅ حقل الموقع بدون مشاكل عرض أو Padding
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      labelText: "الموقع",
                      hintText: "اكتب موقع العميل هنا...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                    ),
                  ),
                  const SizedBox(height: 12),

                  DropdownButtonFormField<String>(
                    value: statusList.contains(newStatus)
                        ? newStatus
                        : statusList.first,
                    decoration: const InputDecoration(
                      labelText: "الحالة",
                      border: OutlineInputBorder(),
                    ),
                    items: statusList
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) => setState(() => newStatus = v!),
                  ),
                ],
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "إلغاء",
                style: TextStyle(color: AppColors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                onSave(newService, newTime, locationController.text, newStatus);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم تعديل الطلب بنجاح ✅")),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Text(
                "حفظ",
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
