import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/core/constants/app_strings.dart';
import 'package:smart_clean/features/user/booking/rating_view/cubit/rating_cubit.dart';
import 'package:smart_clean/features/user/booking/rating_view/widgets/note_field.dart';
import 'package:smart_clean/features/user/booking/rating_view/widgets/rating_card.dart';
import 'package:smart_clean/features/user/booking/rating_view/widgets/submit_button.dart';

class RatingView extends StatelessWidget {
  const RatingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RatingCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary.withOpacity(0.2), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: _RatingBody(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RatingBody extends StatelessWidget {
  const _RatingBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RatingCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.shareOpinion,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 20.h),

        /// 🔹 Rating card
        RatingCard(),

        SizedBox(height: 25.h),

        /// 🔹 Notes Field
        NoteField(controller: cubit.noteController),

        SizedBox(height: 30.h),

        /// 🔹 Submit button
        SubmitButton(
          onPressed: () {
            cubit.submit(context);
          },
        ),

        SizedBox(height: 60.h),
      ],
    );
  }
}
