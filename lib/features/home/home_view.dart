import 'package:flutter/material.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/features/home/views/home_tab.dart';
import 'package:smart_clean/features/home/views/my_bookings_view.dart';
import 'package:smart_clean/features/home/views/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeTab(),
    MyBookingsView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: _screens),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent, // 🔹 يلغي لون الضغط (splash)
          highlightColor: Colors.transparent, // 🔹 يلغي تأثير اللمس
          splashFactory:
              NoSplash.splashFactory, // 🔹 يمنع إنشاء الأنيميشن أصلًا
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: AppColor.textSecondary,
          showUnselectedLabels: true,
          backgroundColor: AppColor.white,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: AppStrings.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              label: AppStrings.myBookings,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: AppStrings.profile,
            ),
          ],
        ),
      ),
    );
  }
}
