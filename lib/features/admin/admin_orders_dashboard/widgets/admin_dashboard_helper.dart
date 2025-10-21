import 'package:flutter/material.dart';

class AdminDashboardHelper {
  static final orders = [
    {
      "client": "Ahmed Hassan",
      "service": "Full Wash",
      "time": "10:00 AM",
      "status": "Pending",
    },
    {
      "client": "Omar Ali",
      "service": "Interior Cleaning",
      "time": "12:30 PM",
      "status": "In Progress",
    },
    {
      "client": "Sara Mohamed",
      "service": "Polish & Shine",
      "time": "04:00 PM",
      "status": "Completed",
    },
  ];

  static Color getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return Colors.green;
      case "In Progress":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  static IconData getStatusIcon(String status) {
    switch (status) {
      case "Completed":
        return Icons.check_circle;
      case "In Progress":
        return Icons.work_history_rounded;
      default:
        return Icons.pending_actions;
    }
  }
}
