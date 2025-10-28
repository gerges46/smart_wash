part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String email;
  final String phone;

  const ProfileLoaded({
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  List<Object?> get props => [name, email, phone];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileSuccess extends ProfileState {
  final String message;
  const ProfileSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileNotificationsLoaded extends ProfileState {
  final List<Map<String, dynamic>> notifications;

  const ProfileNotificationsLoaded({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}
