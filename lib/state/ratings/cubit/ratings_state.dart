part of 'ratings_cubit.dart';

@immutable
abstract class RatingsState extends Equatable {
  const RatingsState();

  @override
  List<Object> get props => [];
}

class RatingsInitial extends RatingsState {}

class RatingsDataChanged extends RatingsState {
  final List<RatingsModel> models;
  RatingsDataChanged(this.models);
  @override
  List<Object> get props => [models];
}

class RatingsLoading extends RatingsState {}

class RatingsEmpty extends RatingsState {}

class RatingAdded extends RatingsState {}
