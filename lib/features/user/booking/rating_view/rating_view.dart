import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clean/core/constants/app_color.dart';
import 'package:smart_clean/features/user/booking/rating_view/cubit/rating_cubit.dart';
import 'package:smart_clean/features/user/booking/rating_view/widgets/rating_body.dart';

class RatingView extends StatelessWidget {
  final String bookingId;
  
  const RatingView({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RatingCubit(bookingId),
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
                child: RatingBody(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}