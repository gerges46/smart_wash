import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/routes/app_router.dart';
import 'package:smart_clean/core/utils/error_handler.dart';
import 'package:smart_clean/features/user/booking/payment/payment_view.dart';
part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(const BookingState());

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
void changeService(String? newService) async {
  emit(state.copyWith(service: newService));

  if (newService != null) {
    try {
      final snapshot = await _firestore
          .collection('services')
          .where('name', isEqualTo: newService)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final price = snapshot.docs.first['price'];
        emit(state.copyWith(price: price.toDouble()));
      }
    } catch (e) {
      debugPrint("❌ Error loading price: $e");
    }
  }
}


  void changeStatus(String? newStatus) {  // ✅ هذه الدالة الجديدة
    emit(state.copyWith(status: newStatus));
  }

  Future<void> pickDate(BuildContext context) async {
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (d != null) emit(state.copyWith(date: d));
  }

  Future<void> pickTime(BuildContext context) async {
    if (state.date == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.dateFirst)),
      );
      return;
    }

    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (t != null) emit(state.copyWith(time: t));
  }

  void changeAddress(String newAddress) {
    emit(state.copyWith(address: newAddress));
  }

  bool validateData(BuildContext context) {
    if (state.service == null ||
        state.date == null ||
        state.time == null ||
        state.address!.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.completeData)),
      );
      return false;
    }
    return true;
  }

Future<void> addBookingToFirestore(BuildContext context) async {
  try {
    final user = _auth.currentUser;
    if (user == null) {
      handleFirebaseError(context, "⚠️ لم يتم تسجيل الدخول. من فضلك سجّل الدخول أولاً.");
      return;
    }

    emit(state.copyWith(isLoading: true));

    final bookingRef = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookings')
        .add({
      'service': state.service,
      'price': state.price,
      'date': state.date?.toIso8601String(),
      'time': state.time?.format(context),
      'address': state.address,
      'createdAt': FieldValue.serverTimestamp(),
      'isPaid': false,
      'isCancelled': false,
      'status': AppStrings.bookingStatusPending, // 🟢 الحالة المبدئية للحجز
    });

    emit(state.copyWith(
      bookingId: bookingRef.id,
      status: AppStrings.bookingStatusPending, // 🟢 نحدث الحالة في الـ state أيضًا
      isLoading: false,
    ));

    // ✅ رسالة نجاح للمستخدم
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("✅ تم إرسال الحجز بنجاح وهو الآن قيد الانتظار."),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // 🔹 الانتقال إلى شاشة الدفع
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentView(bookingId: bookingRef.id),
      ),
    );
  } catch (e) {
    emit(state.copyWith(isLoading: false));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("❌ حدث خطأ أثناء إرسال الحجز: $e"),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}




Future<void> getLastBooking() async {
  emit(state.copyWith(isLoading: true));
  try {
    final user = _auth.currentUser;
    if (user == null) {
      emit(state.copyWith(isLoading: false));
      return;
    }

    final snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookings')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      emit(state.copyWith(
        lastBooking: snapshot.docs.first.data(),
        isLoading: false,
      ));
    } else {
      emit(state.copyWith(lastBooking: null, isLoading: false));
    }
  } catch (e) {
    debugPrint("❌ Error loading last booking: $e");
    emit(state.copyWith(isLoading: false));
  }
}


Future<void> pay(BuildContext context) async {
  try {
    emit(state.copyWith(isPaying: true));

    final user = _auth.currentUser;
    if (user == null || state.bookingId == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookings')
        .doc(state.bookingId)
        .update({'isPaid': true}); // ✅ تم الدفع

    emit(state.copyWith(isPaying: false, isPaid: true));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم الدفع بنجاح ✅")),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.bookingDetailsRoute,
        (route) => false,
      );
    }
  } catch (e) {
    emit(state.copyWith(isPaying: false));
    handleFirebaseError(context, e);
  }
}

Future<void> cancelBooking(BuildContext context) async {
  try {
    final user = _auth.currentUser;
    final bookingId = state.bookingId;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ لم يتم العثور على مستخدم مسجل الدخول")),
      );
      return;
    }

    if (bookingId == null || bookingId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ لم يتم العثور على رقم الحجز لإلغائه")),
      );
      return;
    }

    final docRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookings')
        .doc(bookingId);

    final doc = await docRef.get();

    if (!doc.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ لا يمكن إلغاء هذا الحجز لأنه غير موجود.")),
      );
      return;
    }

    await docRef.delete();
    emit(state.copyWith(isCancelled: true));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("✅ تم إلغاء الحجز بنجاح"),
        backgroundColor: Colors.green,
      ),
    );
  } catch (e) {
    debugPrint("❌ خطأ أثناء حذف الحجز: $e");
    handleFirebaseError(context, e);
  }
}



Future<bool> confirmExit(BuildContext context) async {
  if (state.isPaid || state.isCancelled) return true;

  bool confirmExit = false;
  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("تأكيد الخروج"),
      content: const Text("هل تريد إلغاء الحجز؟ سيتم حذفه إن خرجت الآن."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("إلغاء"),
        ),
        TextButton(
          onPressed: () {
            confirmExit = true;
            Navigator.pop(context, true);
          },
          child: const Text("تأكيد"),
        ),
      ],
    ),
  );

  if (confirmExit) {
    await cancelBooking(context);
  }

  return confirmExit;
}


  /// 🟢 لتخزين الـ bookingId عند فتح صفحة الدفع
  void setBookingId(String id) {
    emit(state.copyWith(bookingId: id));
  }

  
Future<void> confirmCashPayment(BuildContext context) async {
  try {
    final user = _auth.currentUser;
    final bookingId = state.bookingId;

    if (user == null || bookingId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ لم يتم العثور على بيانات الحجز")),
      );
      return;
    }

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookings')
        .doc(bookingId)
        .update({
      'isPaid': false,
      'paymentMethod': 'cash',
      'status': 'confirmed',
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("✅ تم تأكيد الدفع عند التنفيذ."),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.bookingDetailsRoute,
      (route) => false,
    );
  } catch (e) {
    debugPrint("❌ خطأ أثناء تأكيد الدفع عند التنفيذ: $e");
    handleFirebaseError(context, e);
  }
}

Future<void> getUserBookings() async {
  emit(state.copyWith(isLoading: true));
  try {
    final user = _auth.currentUser;
    if (user == null) {
      emit(state.copyWith(isLoading: false, userBookings: []));
      return;
    }

    final snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookings')
        .orderBy('createdAt', descending: true)
        .get();

    // ✅ تحويل البيانات بدون مشاكل
    final bookings = snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        "id": doc.id,
        "service": data['service'] ?? "غير محدد",
        "price": "${data['price']} ج.م",
        "date": data['date'] ?? "",
        "time": data['time'] ?? "",
        "status": data['status'] ?? "غير معروف",
        "address": data['address'] ?? "", // مهم تضيفه لأنه موجود عندك
      };
    }).toList();

    emit(state.copyWith(
      userBookings: bookings,
      isLoading: false,
    ));
    debugPrint("✅ تم تحميل الحجوزات بنجاح: ${bookings.length} حجوزات.");
  } catch (e) {
    debugPrint("❌ خطأ أثناء تحميل الحجوزات: $e");
    emit(state.copyWith(isLoading: false, userBookings: []));
  }
}


  
}

