import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:smart_clean/core/routes/app_router.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(const RatingState());

  double rating = 4.0;
  final TextEditingController noteController = TextEditingController();

  void updateRating(double value) {
    rating = value;
    emit(RatingUpdated(rating));
  }

  void submit(BuildContext context) {
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("شكراً لتقييمك!")));
    Navigator.pushNamedAndRemoveUntil(context, Routes.bottomNavRoute, (_) => false);
  }

  @override
  Future<void> close() {
    noteController.dispose();
    return super.close();
  }
}
