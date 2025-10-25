part of 'rating_cubit.dart';

abstract class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object?> get props => [];
}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingSuccess extends RatingState {}

class RatingError extends RatingState {
  final String message;
  const RatingError(this.message);

  @override
  List<Object?> get props => [message];
}

class RatingUpdated extends RatingState {
  final double rating;
  const RatingUpdated(this.rating);

  @override
  List<Object?> get props => [rating];
}