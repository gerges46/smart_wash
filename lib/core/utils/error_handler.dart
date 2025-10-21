import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void handleFirebaseError(BuildContext context, dynamic e) {
  String errorMessage = "حدث خطأ غير متوقع، حاول مرة أخرى لاحقًا.";

  if (e is FirebaseException) {
    switch (e.code) {
      case 'permission-denied':
        errorMessage = "ليس لديك صلاحية لتنفيذ هذا الإجراء.";
        break;
      case 'unavailable':
        errorMessage = "الخدمة غير متاحة حاليًا، حاول بعد قليل.";
        break;
      case 'unimplemented':
        errorMessage = "ميزة غير مدعومة على هذا الجهاز.";
        break;
      case 'invalid-argument':
        errorMessage = "حدث خطأ في البيانات المُدخلة.";
        break;
      case 'failed-precondition':
        errorMessage = "هناك خطأ في إعداد قاعدة البيانات. يُرجى المحاولة لاحقًا.";
        break;
      default:
        errorMessage = "حدث خطأ أثناء الاتصال بالخادم.";
    }
  } else if (e.toString().contains("network")) {
    errorMessage = "تحقق من اتصال الإنترنت.";
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(errorMessage)),
  );
}
