import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_clean/core/constants/app_strings.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(const BookingState());

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  void changeService(String? newService) {
    emit(state.copyWith(service: newService));
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
          const SnackBar(content: Text("يجب تسجيل الدخول أولاً")),
        );
        return;
      }

      // 🔍 تحويل الوقت لصيغة موحدة
      final selectedTime = "${state.time!.hour}:${state.time!.minute}";
      final selectedDate = DateTime(
        state.date!.year,
        state.date!.month,
        state.date!.day,
      );

      // 🧠 تحقق إذا كان هذا الموعد محجوز مسبقًا
      final existing = await _firestore
          .collectionGroup('bookings')
          .where('date', isEqualTo: selectedDate.toIso8601String())
          .where('time', isEqualTo: selectedTime)
          .get();

      if (existing.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("⚠️ هذا الموعد محجوز بالفعل! اختر وقتًا آخر."),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // ✅ إضافة الحجز الجديد
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('bookings')
          .add({
        'service': state.service,
        'date': selectedDate.toIso8601String(),
        'time': selectedTime,
        'address': state.address,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ تم حجز الخدمة بنجاح!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ أثناء الحجز: $e")),
      );
    }
  }
}
