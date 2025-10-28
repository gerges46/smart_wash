part of 'payment_history_cubit.dart';

abstract class PaymentHistoryState extends Equatable {
  const PaymentHistoryState();

  @override
  List<Object?> get props => [];
}

class PaymentHistoryLoading extends PaymentHistoryState {}

class PaymentHistoryLoaded extends PaymentHistoryState {
  final List<Map<String, dynamic>> payments;
  final String selectedFilter;

  const PaymentHistoryLoaded({
    required this.payments,
    this.selectedFilter = "الكل",
  });

  @override
  List<Object?> get props => [payments, selectedFilter];
}

class PaymentHistoryError extends PaymentHistoryState {
  final String message;

  const PaymentHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
