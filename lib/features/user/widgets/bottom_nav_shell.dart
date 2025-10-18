// lib/features/user/widgets/bottom_nav_shell.dart
import 'package:flutter/material.dart';
import 'package:smart_clean/features/user/booking/my_bookings/my_bookings_view.dart';
import 'package:smart_clean/features/user/home/home_view.dart';
import 'package:smart_clean/features/user/profile/profile_view.dart';
import 'package:smart_clean/core/constants/app_color.dart';

class BottomNavShell extends StatefulWidget {
  const BottomNavShell({super.key});

  @override
  State<BottomNavShell> createState() => _BottomNavShellState();
}

class _BottomNavShellState extends State<BottomNavShell> {
  int _index = 0;
  final List<Widget> _pages = const [
    HomeView(),
    MyBookingsView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkGrey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online_outlined),
            label: "حجوزاتي",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "حسابي",
          ),
        ],
      ),
    );
  }
}
