import 'package:equatable/equatable.dart';

class AdminScheduleState extends Equatable {
  final bool isLoading;
  final Map<String, List<Map<String, dynamic>>> schedule;
  final String? errorMessage;

  const AdminScheduleState({
    this.isLoading = false,
    this.schedule = const {},
    this.errorMessage,
  });

  AdminScheduleState copyWith({
    bool? isLoading,
    Map<String, List<Map<String, dynamic>>>? schedule,
    String? errorMessage,
  }) {
    return AdminScheduleState(
      isLoading: isLoading ?? this.isLoading,
      schedule: schedule ?? this.schedule,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, schedule, errorMessage];
}
