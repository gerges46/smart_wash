import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        "title": AppStrings.service1,
        "price": "50 EGP",
        "icon": Icons.local_car_wash,
        "color": Colors.blueAccent,
      },
      {
        "title": AppStrings.service2,
        "price": "70 EGP",
        "icon": Icons.cleaning_services,
        "color": Colors.green,
      },
      {
        "title": AppStrings.service3,
        "price": "120 EGP",
        "icon": Icons.star_rate_rounded,
        "color": Colors.amber,
      },
      {
        "title": AppStrings.service4,
        "price": "80 EGP",
        "icon": Icons.build_circle,
        "color": Colors.deepPurple,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.ourServices,
              style: TextStyle(
                fontSize: AppSize.s18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(onPressed: () {}, child: const Text(AppStrings.viewAll)),
          ],
        ),
        SizedBox(height: AppSize.s8.h),
        SizedBox(
          height: AppSize.s160.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            separatorBuilder: (_, __) => SizedBox(width: AppSize.s12.w),
            itemBuilder: (context, i) {
              final s = services[i];
              return _ServiceCard(
                title: s['title'] as String,
                price: s['price'] as String,
                icon: s['icon'] as IconData,
                color: s['color'] as Color,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final String price;
  final IconData icon;
  final Color color;

  const _ServiceCard({
    required this.title,
    required this.price,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s140.w,
      padding: EdgeInsets.all(AppPadding.p12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSize.s16.r),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: AppSize.s26.r,
            backgroundColor: color.withOpacity(0.12),
            child: Icon(icon, color: color),
          ),
          const Spacer(),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: AppSize.s6.h),
          Text(price, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }
}
