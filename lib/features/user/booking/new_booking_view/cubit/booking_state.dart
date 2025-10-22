part of 'booking_cubit.dart';

class BookingState extends Equatable {
  final String? service;
  final DateTime? date;
  final TimeOfDay? time;
  final String? address;
  final String? status;
  final Map<String, dynamic>? lastBooking;
  final bool isLoading;

  const BookingState({
    this.service,
    this.date,
    this.time,
    this.address,
    this.status,
    this.lastBooking,
    this.isLoading = false,
  });

  BookingState copyWith({
    String? service,
    DateTime? date,
    TimeOfDay? time,
    String? address,
    String? status,
    Map<String, dynamic>? lastBooking,
    bool? isLoading,
  }) {
    return BookingState(
      service: service ?? this.service,
      date: date ?? this.date,
      time: time ?? this.time,
      address: address ?? this.address,
      status: status ?? this.status,
      lastBooking: lastBooking ?? this.lastBooking,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props =>
      [service, date, time, address, status, lastBooking, isLoading];
}

