// lib/features/auth/forgot_password/cubit/forgot_password_cubit.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotInitial());

  int _seconds = 60;
  Timer? _timer;

  // 1) send code to email/phone (simulate API)
  Future<void> sendCode(String contact) async {
    if (contact.trim().isEmpty) {
      emit(const ForgotError("من فضلك أدخل البريد الإلكتروني أو رقم الجوال"));
      await Future.delayed(const Duration(milliseconds: 400));
      emit(ForgotInitial());
      return;
    }

    emit(ForgotLoading());
    await Future.delayed(const Duration(seconds: 1)); // simulate API delay

    // simulate success
    emit(ForgotCodeSent(contact));
    startTimer();
  }

  // 2) start timer
  void startTimer() {
    _timer?.cancel();
    _seconds = 60;
    emit(ForgotTimerRunning(_seconds));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 1) {
        _seconds--;
        emit(ForgotTimerRunning(_seconds));
      } else {
        _seconds = 0;
        timer.cancel();
        emit(ForgotCanResend());
      }
    });
  }

  // 3) resend code
  Future<void> resendCode() async {
    if (_seconds == 0) {
      emit(ForgotLoading());
      await Future.delayed(const Duration(seconds: 1)); // simulate API
      emit(ForgotCodeSent("")); // contact not required here
      startTimer();
    }
  }

  // 4) verify OTP code (simulate)
  Future<void> verifyCode(String code) async {
    if (code.trim().length < 4) {
      emit(const ForgotError("ادخل رمز مكون من 4 أرقام"));
      await Future.delayed(const Duration(milliseconds: 600));
      emit(ForgotCodeSent(""));
      return;
    }

    emit(ForgotVerifying());
    await Future.delayed(const Duration(seconds: 2)); // simulate API

    // simulate logic: accept "1234"
    if (code == "1234") {
      emit(ForgotVerified());
    } else {
      emit(const ForgotError("رمز التحقق غير صحيح"));
      await Future.delayed(const Duration(milliseconds: 600));
      emit(ForgotCodeSent(""));
      startTimer();
    }
  }

  // 5) reset password (simulate)
  Future<void> resetPassword(String password, String confirm) async {
    if (password.isEmpty || confirm.isEmpty) {
      emit(const ForgotError("من فضلك أكمل جميع الحقول"));
      await Future.delayed(const Duration(milliseconds: 600));
      emit(ForgotVerified());
      return;
    }
    if (password.length < 6) {
      emit(const ForgotError("كلمة المرور يجب أن تكون 6 أحرف على الأقل"));
      await Future.delayed(const Duration(milliseconds: 600));
      emit(ForgotVerified());
      return;
    }
    if (password != confirm) {
      emit(const ForgotError("كلمة المرور وتأكيدها غير متطابقتين"));
      await Future.delayed(const Duration(milliseconds: 600));
      emit(ForgotVerified());
      return;
    }

    emit(ForgotResetting());
    await Future.delayed(const Duration(seconds: 2)); // simulate API

    emit(const ForgotSuccess("تم تغيير كلمة المرور بنجاح"));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
