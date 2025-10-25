import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User? user; // ← خليها nullable
  final bool isAdmin;

  AuthSuccess({required this.user, required this.isAdmin});
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure({required this.message});
}

class AuthLoggedOut extends AuthState {}

class AuthPasswordResetEmailSentSuccess extends AuthState {}
class AuthPasswordResetEmailSentFailure extends AuthState {
  final String message;
  AuthPasswordResetEmailSentFailure({required this.message});
}
class AuthPasswordResetEmailSentLoading extends AuthState {}

class PasswordVisibilityChanged extends AuthState {
  final bool isVisible;
  PasswordVisibilityChanged(this.isVisible);
}
