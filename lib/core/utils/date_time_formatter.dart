import 'package:cloud_firestore/cloud_firestore.dart';

/// 🔹 دالة لتنسيق التاريخ والوقت من Firestore أو String
String formatDateTime(dynamic dateValue, String? timeValue) {
  try {
    if (dateValue == null) return "غير محدد";

    // لو التاريخ من Firestore
    DateTime date = dateValue is Timestamp
        ? dateValue.toDate()
        : DateTime.tryParse(dateValue.toString()) ?? DateTime.now();

    // تنسيق التاريخ (مثلاً: 22/10/2025)
    String formattedDate =
        "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";

    // الوقت (لو موجود)
    String formattedTime =
        timeValue != null && timeValue.isNotEmpty ? " - $timeValue" : "";

    return "$formattedDate$formattedTime";
  } catch (e) {
    return "غير معروف";
  }
}
