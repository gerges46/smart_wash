part of 'booking_cubit.dart';
class BookingState extends Equatable {
  final String? service;
  final double? price; // ✅ السعر الجديد
  final DateTime? date;
  final TimeOfDay? time;
  final String? address;
  final String? status;
  final Map<String, dynamic>? lastBooking;
  final bool isLoading;
   final String? bookingId;
  final bool isPaying;
  final bool isPaid;
  final bool isCancelled;


  const BookingState({
    this.service,
    this.price, // ✅
    this.date,
    this.time,
    this.address,
    this.status,
    this.lastBooking,
    this.isLoading = false,
    this.bookingId,
    this.isPaying = false,
    this.isPaid = false,
    this.isCancelled = false,
  });

  BookingState copyWith({
    String? service,
    double? price, // ✅
    DateTime? date,
    TimeOfDay? time,
    String? address,
    String? status,
    Map<String, dynamic>? lastBooking,
    bool? isLoading,
     String? bookingId,
    bool? isPaying,
    bool? isPaid,
    bool? isCancelled,
  }) {
    return BookingState(
      service: service ?? this.service,
      price: price ?? this.price, // ✅
      date: date ?? this.date,
      time: time ?? this.time,
      address: address ?? this.address,
      status: status ?? this.status,
      lastBooking: lastBooking ?? this.lastBooking,
      isLoading: isLoading ?? this.isLoading,
       bookingId: bookingId ?? this.bookingId,
      isPaying: isPaying ?? this.isPaying,
      isPaid: isPaid ?? this.isPaid,
      isCancelled: isCancelled ?? this.isCancelled,
    );
  }

  @override
  List<Object?> get props =>
      [service, price, date, time, address, status, lastBooking, isLoading,bookingId, isPaying, isPaid, isCancelled];
}
