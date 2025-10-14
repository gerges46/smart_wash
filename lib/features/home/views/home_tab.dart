import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/core/constants/value_manager.dart';
import 'package:smart_clean/features/home/views/widgets/home_header.dart';
import 'package:smart_clean/features/home/views/widgets/service_card.dart';
import 'package:smart_clean/features/home/views/widgets/why_us_tile.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p20.w,
        vertical: AppPadding.p20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeHeader(),
          SizedBox(height: AppSize.s20.h),

          Text(
            AppStrings.ourServices,
            style: TextStyle(
              fontSize: AppSize.s20.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.textPrimary,
            ),
          ),
          SizedBox(height: AppSize.s16.h),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: AppSize.s16.h,
            crossAxisSpacing: AppSize.s16.w,
            childAspectRatio: 1.1,
            children: const [
              ServiceCard(
                color: AppColor.lightBlueBackground,
                iconColor: AppColor.primaryColor,
                title: AppStrings.externalWash,
                price: AppStrings.externalPrice,
              ),
              ServiceCard(
                color: AppColor.lightPurpleBackground,
                iconColor: AppColor.purple,
                title: AppStrings.internalWash,
                price: AppStrings.internalPrice,
              ),
              ServiceCard(
                color: AppColor.lightGreenBackground,
                iconColor: AppColor.green,
                title: AppStrings.fullWash,
                price: AppStrings.fullPrice,
              ),
              ServiceCard(
                color: AppColor.lightYellowBackground,
                iconColor: AppColor.yellow,
                title: AppStrings.polish,
                price: AppStrings.polishPrice,
              ),
            ],
          ),

          SizedBox(height: AppSize.s28.h),
          Text(
            AppStrings.whyUs,
            style: TextStyle(
              fontSize: AppSize.s18.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.textPrimary,
            ),
          ),
          SizedBox(height: AppSize.s16.h),

          const WhyUsTile(
            icon: Icons.location_on_outlined,
            title: AppStrings.mobileService,
            subtitle: AppStrings.mobileServiceDesc,
          ),
          SizedBox(height: AppSize.s12.h),
          const WhyUsTile(
            icon: Icons.access_time_outlined,
            title: AppStrings.flexibleTimes,
            subtitle: AppStrings.flexibleTimesDesc,
          ),
          SizedBox(height: AppSize.s12.h),
          const WhyUsTile(
            icon: Icons.local_car_wash_outlined,
            title: AppStrings.highQuality,
            subtitle: AppStrings.highQualityDesc,
          ),
        ],
      ),
    );
  }
}
