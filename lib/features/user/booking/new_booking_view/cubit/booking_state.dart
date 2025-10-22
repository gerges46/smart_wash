part of 'booking_cubit.dart';

class BookingState extends Equatable {
  final String? service;
  final DateTime? date;
  final TimeOfDay? time;
  final String address;
  final String status; // ✅ الحالة ثابتة

  const BookingState({
    this.service,
    this.date,
    this.time,
    this.address = "",
    this.status = AppStrings.bookingStatusPending, // ✅ قيمة افتراضية
  });

  BookingState copyWith({
    String? service,
    DateTime? date,
    TimeOfDay? time,
    String? address,
    String? status,
  }) {
    return BookingState(
      service: service ?? this.service,
      date: date ?? this.date,
      time: time ?? this.time,
      address: address ?? this.address,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [service, date, time, address, status];
}
