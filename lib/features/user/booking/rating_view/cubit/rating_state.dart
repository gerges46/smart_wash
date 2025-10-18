part of 'rating_cubit.dart';

class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object?> get props => [];
}

class RatingUpdated extends RatingState {
  final double rating;
  const RatingUpdated(this.rating);

  @override
  List<Object?> get props => [rating];
}
