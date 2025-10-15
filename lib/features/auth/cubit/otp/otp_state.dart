import 'package:equatable/equatable.dart';

abstract class OTPState extends Equatable {
  const OTPState();

  @override
  List<Object?> get props => [];
}

class OTPInitial extends OTPState {}

class OTPTimerRunning extends OTPState {
  final int seconds;
  const OTPTimerRunning(this.seconds);

  @override
  List<Object?> get props => [seconds];
}

class OTPCanResend extends OTPState {}

class OTPVerifying extends OTPState {}

class OTPVerified extends OTPState {}

class OTPError extends OTPState {
  final String message;
  const OTPError(this.message);

  @override
  List<Object?> get props => [message];
}
