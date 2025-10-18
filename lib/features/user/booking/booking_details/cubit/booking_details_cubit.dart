import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'booking_details_state.dart';

class BookingDetailsCubit extends Cubit<BookingDetailsState> {
  BookingDetailsCubit() : super(BookingDetailsInitial());

  void cancelBooking() {
    emit(BookingCancelled());
  }

  void rateBooking() {
    emit(BookingRated());
  }
}
