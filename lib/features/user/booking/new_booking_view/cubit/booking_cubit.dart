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
          const SnackBar(content: Text("Please log in first.")),
        );
        return;
      }

      // 🔍 Format selected time and date
      final selectedTime = "${state.time!.hour}:${state.time!.minute}";
      final selectedDate = DateTime(
        state.date!.year,
        state.date!.month,
        state.date!.day,
      );

      // 🧠 Check if this slot is already booked
      final existing = await _firestore
          .collectionGroup('bookings')
          .where('date', isEqualTo: selectedDate.toIso8601String())
          .where('time', isEqualTo: selectedTime)
          .get();

      if (existing.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("⚠️ This time slot is already booked! Please choose another."),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // ✅ Add new booking
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
          content: Text("✅ Booking confirmed successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // ✅ هنا استخدمنا ملف الـ error handler بدل الرسالة العادية
      handleFirebaseError(context, e);
    }
  }
}
