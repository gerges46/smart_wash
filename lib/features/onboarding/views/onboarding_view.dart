import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> onboardingData = [
    {
      "title": AppStrings.onboardingTitle1,
      "subtitle": AppStrings.onboardingSub1,
      "icon": Icons.local_car_wash,
      "color": AppColors.primary,
    },
    {
      "title": AppStrings.onboardingTitle2,
      "subtitle": AppStrings.onboardingSub2,
      "icon": Icons.schedule,
      "color": AppColors.orange,
    },
    {
      "title": AppStrings.onboardingTitle3,
      "subtitle": AppStrings.onboardingSub3,
      "icon": Icons.flash_on,
      "color": AppColors.green,
    },
  ];

  void _nextPage() {
    if (_currentIndex < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      _goToLogin();
    }
  }

  void _goToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  final data = onboardingData[index];
                  return Padding(
                    padding: EdgeInsets.all(AppPadding.p24.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: AppSize.s70.r,
                          backgroundColor: data['color'].withOpacity(0.1),
                          child: Icon(
                            data['icon'],
                            color: data['color'],
                            size: AppSize.s70.sp,
                          ),
                        ),
                        SizedBox(height: AppSize.s40.h),
                        Text(
                          data['title'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: AppSize.s22.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: AppSize.s15.h),
                        Text(
                          data['subtitle'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: AppSize.s16.sp,
                            color: AppColors.grey.withOpacity(0.7),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p24.w,
                vertical: AppPadding.p24.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // المؤشرات
                  Row(
                    children: List.generate(
                      onboardingData.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        width: _currentIndex == index ? 20.w : 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? AppColors.primary
                              : AppColors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  // الزر
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(
                        horizontal: 35.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _currentIndex == onboardingData.length - 1
                          ? AppStrings.startNow
                          : AppStrings.next,
                      style: TextStyle(
                        fontSize: AppSize.s16.sp,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
