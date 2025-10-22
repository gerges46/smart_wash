import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/utils/error_handler.dart'; // ✅ استخدمنا ملف الأخطاء هنا

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(const BookingState());

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  void changeService(String? newService) {
    emit(state.copyWith(service: newService));
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
        state.address.trim().isEmpty) {
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠️ يجب تسجيل الدخول أولًا."),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // ✅ احفظ التاريخ كنص YYYY-MM-DD (أسهل للبحث والمقارنة)
    final selectedDateString =
        "${state.date!.year}-${state.date!.month}-${state.date!.day}";
    final selectedTime = "${state.time!.hour}:${state.time!.minute}";

    // ✅ تحقق إن الوقت مش محجوز
    final existing = await _firestore
        .collectionGroup('bookings')
        .where('date', isEqualTo: selectedDateString)
        .where('time', isEqualTo: selectedTime)
        .get();

    if (existing.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠️ هذا الوقت محجوز مسبقًا، اختر وقتًا آخر."),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // ✅ أضف الحجز الجديد
    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookings')
        .add({
      'service': state.service,
      'date': selectedDateString, // نص بدل Timestamp
      'time': selectedTime,
      'address': state.address,
      'status': AppStrings.bookingStatusPending,
      'createdAt': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("✅ تم الحجز بنجاح!"),
        backgroundColor: Colors.green,
      ),
    );
  } catch (e) {
    handleFirebaseError(context, e);
  }
}



}

