import 'package:flutter/material.dart';
import 'package:smart_clean/core/constants/app_strings.dart';

class AdminDashboardHelper {
  static final orders = [
    {
      "client": "Ahmed Hassan",
      "service": "Full Wash",
      "time": "10:00 AM",
      "status": AppStrings.bookingStatusPending,
    },
    {
      "client": "Omar Ali",
      "service": "Interior Cleaning",
      "time": "12:30 PM",
      "status": AppStrings.bookingStatusInProgress,
    },
    {
      "client": "Sara Mohamed",
      "service": "Polish & Shine",
      "time": "04:00 PM",
      "status": AppStrings.bookingStatusCompleted,
    },
  ];

  static Color getStatusColor(String status) {
    switch (status) {
      case AppStrings.bookingStatusCompleted:
        return Colors.green;
      case AppStrings.bookingStatusInProgress:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  static IconData getStatusIcon(String status) {
    switch (status) {
      case AppStrings.bookingStatusCompleted:
        return Icons.check_circle;
      case AppStrings.bookingStatusInProgress:
        return Icons.work_history_rounded;
      default:
        return Icons.pending_actions;
    }
  }
}
