part of 'booking_cubit.dart';

class BookingState extends Equatable {
  final String? service;
  final DateTime? date;
  final TimeOfDay? time;
  final String address;

  const BookingState({this.service, this.date, this.time, this.address = ""});

  BookingState copyWith({
    String? service,
    DateTime? date,
    TimeOfDay? time,
    String? address,
  }) {
    return BookingState(
      service: service ?? this.service,
      date: date ?? this.date,
      time: time ?? this.time,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [service, date, time, address];
}
