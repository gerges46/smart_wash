import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:smart_clean/core/constants/app_strings.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(const BookingState());

  final List<Map<String, dynamic>> existingBookings = [
    {
      "date": DateTime(2025, 10, 16),
      "time": const TimeOfDay(hour: 10, minute: 0),
    },
    {
      "date": DateTime(2025, 10, 16),
      "time": const TimeOfDay(hour: 14, minute: 30),
    },
  ];

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
    if (d != null) {
      emit(state.copyWith(date: d));
    }
  }

  Future<void> pickTime(BuildContext context) async {
    if (state.date == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.dateFirst)));
      return;
    }

    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (t != null) {
      bool isBooked = existingBookings.any(
        (b) =>
            b['date'].year == state.date!.year &&
            b['date'].month == state.date!.month &&
            b['date'].day == state.date!.day &&
            b['time'].hour == t.hour &&
            b['time'].minute == t.minute,
      );

      if (isBooked) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text(AppStrings.bookedTime)));
        return;
      }

      emit(state.copyWith(time: t));
    }
  }

  void changeAddress(String newAddress) {
    emit(state.copyWith(address: newAddress));
  }

  bool validateData(BuildContext context) {
    if (state.service == null ||
        state.date == null ||
        state.time == null ||
        state.address.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.completeData)));
      return false;
    }
    return true;
  }
}
