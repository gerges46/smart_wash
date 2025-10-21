import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final bool loading;
  final List<Map<String, dynamic>> services;
  final String? error;

  const DashboardState({
    this.loading = false,
    this.services = const [],
    this.error,
  });

  DashboardState copyWith({
    bool? loading,
    List<Map<String, dynamic>>? services,
    String? error,
  }) {
    return DashboardState(
      loading: loading ?? this.loading,
      services: services ?? this.services,
      error: error,
    );
  }

  @override
  List<Object?> get props => [loading, services, error];
}
