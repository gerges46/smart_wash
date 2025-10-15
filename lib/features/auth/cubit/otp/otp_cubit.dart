import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_state.dart';

class OTPCubit extends Cubit<OTPState> {
  OTPCubit() : super(OTPInitial());

  int _seconds = 60;
  bool get canResend => _seconds == 0;
  Timer? _timer;

  void startTimer() {
    _seconds = 60;
    _timer?.cancel();
    emit(OTPTimerRunning(_seconds));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 1) {
        _seconds--;
        emit(OTPTimerRunning(_seconds));
      } else {
        _seconds = 0;
        timer.cancel();
        emit(OTPCanResend());
      }
    });
  }

  void resendCode() {
    if (_seconds == 0) {
      startTimer();
      emit(OTPInitial()); // ممكن بعدين تضيف API call هنا
    }
  }

  void verifyCode(String code) async {
    emit(OTPVerifying());
    await Future.delayed(const Duration(seconds: 2)); // محاكاة API

    if (code == "1234") {
      emit(OTPVerified());
    } else {
      emit(const OTPError("رمز التحقق غير صحيح ❌"));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
