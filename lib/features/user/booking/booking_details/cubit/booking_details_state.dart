part of 'booking_details_cubit.dart';

abstract class BookingDetailsState extends Equatable {
  const BookingDetailsState();

  @override
  List<Object?> get props => [];
}

class BookingDetailsInitial extends BookingDetailsState {}

class BookingCancelled extends BookingDetailsState {}

class BookingRated extends BookingDetailsState {}
