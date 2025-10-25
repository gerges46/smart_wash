import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/features/user/booking/rating_view/cubit/rating_cubit.dart';
import 'package:smart_clean/features/user/booking/rating_view/widgets/note_field.dart';
import 'package:smart_clean/features/user/booking/rating_view/widgets/rating_card.dart';
import 'package:smart_clean/features/user/booking/rating_view/widgets/submit_button.dart';
import 'package:smart_clean/features/user/booking/rating_view/widgets/skip_button.dart'; // أضف هذا الـ import

class RatingBody extends StatelessWidget {
  const RatingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RatingCubit, RatingState>(
      listener: (context, state) {
        if (state is RatingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message))
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<RatingCubit>();
        
        final bool isLoading = state is RatingLoading;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // زر الإغلاق أو Back في الأعلى
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.close, color: AppColors.darkGrey, size: 28.sp),
                onPressed: () => cubit.skipRating(context),
              ),
            ),
            
            SizedBox(height: 10.h),
            
            Text(
              AppStrings.shareOpinion,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            
            SizedBox(height: 8.h),
            
            Text(
              "شاركنا رأيك لنساعدك بشكل أفضل",
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.darkGrey,
              ),
            ),

            SizedBox(height: 25.h),

            /// 🔹 Rating card
            RatingCard(),

            SizedBox(height: 25.h),

            /// 🔹 Notes Field
            NoteField(controller: cubit.noteController),

            SizedBox(height: 30.h),

            /// 🔹 Submit button
            SubmitButton(
              onPressed: isLoading ? null : () => cubit.submit(context),
              isLoading: isLoading,
            ),

            SizedBox(height: 15.h),

            /// 🔹 Skip Button
            SkipButton(
              onPressed: isLoading ? null : () => cubit.skipRating(context),
              isLoading: isLoading,
            ),

            SizedBox(height: 30.h),
          ],
        );
      },
    );
  }
}