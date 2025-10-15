// lib/features/auth/forgot_password/cubit/forgot_password_state.dart
import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object?> get props => [];
}

class ForgotInitial extends ForgotPasswordState {}

class ForgotLoading extends ForgotPasswordState {}

class ForgotCodeSent extends ForgotPasswordState {
  final String contact; // email or phone
  const ForgotCodeSent(this.contact);

  @override
  List<Object?> get props => [contact];
}

class ForgotTimerRunning extends ForgotPasswordState {
  final int seconds;
  const ForgotTimerRunning(this.seconds);

  @override
  List<Object?> get props => [seconds];
}

class ForgotCanResend extends ForgotPasswordState {}

class ForgotVerifying extends ForgotPasswordState {}

class ForgotVerified extends ForgotPasswordState {}

class ForgotResetting extends ForgotPasswordState {}

class ForgotSuccess extends ForgotPasswordState {
  final String message;
  const ForgotSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ForgotError extends ForgotPasswordState {
  final String message;
  const ForgotError(this.message);

  @override
  List<Object?> get props => [message];
}
