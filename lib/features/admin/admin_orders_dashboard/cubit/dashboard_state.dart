import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final bool loading;
  final List<Map<String, dynamic>> services;
  final List<Map<String, dynamic>> adminBookings; // ✅ أضفنا
  final String? error;

  const DashboardState({
    this.loading = false,
    this.services = const [],
    this.adminBookings = const [], // ✅ قيمة افتراضية
    this.error,
  });

  DashboardState copyWith({
    bool? loading,
    List<Map<String, dynamic>>? services,
    List<Map<String, dynamic>>? adminBookings,
    String? error,
  }) {
    return DashboardState(
      loading: loading ?? this.loading,
      services: services ?? this.services,
      adminBookings: adminBookings ?? this.adminBookings,
      error: error,
    );
  }

  @override
  List<Object?> get props => [loading, services, adminBookings, error];
}
