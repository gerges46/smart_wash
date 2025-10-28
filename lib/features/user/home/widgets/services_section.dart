import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/features/user/home/cubit/home_cubit.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
         if (state is HomeInitial || state is HomeLoading) {
      return const Center(child: CircularProgressIndicator());
      } else if (state is HomeError) {
      return Center(child: Text(state.message));
      }else if (state is HomeLoaded) {
          final services = state.services;

          // ⚡ ثبّتنا الألوان والأيقونات هنا
          final colors = [Colors.blueAccent, Colors.green, Colors.amber, Colors.deepPurple];
          final icons = [Icons.local_car_wash, Icons.cleaning_services, Icons.star_rate_rounded, Icons.build_circle];

          return  Column(
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
       
      ],
    ),
    SizedBox(height: AppSize.s8.h),
    SizedBox(
      height: AppSize.s160.h, // ده الـ height للكاردز
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        separatorBuilder: (_, __) => SizedBox(width: AppSize.s12.w),
        itemBuilder: (context, i) {
          final s = services[i];
          return _ServiceCard(
            title: s['name'] as String,
            price: s['price'] as String,
            icon: icons[i % icons.length],
            color: colors[i % colors.length],
          );
        },
      ),
    ),
  ],
);

        }
        return const SizedBox();
      },
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
