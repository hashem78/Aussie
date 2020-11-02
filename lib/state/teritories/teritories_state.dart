part of 'teritories_cubit.dart';

@immutable
abstract class TeritoriesState extends Equatable {
  const TeritoriesState();

  @override
  List<Object> get props => [];
}

@immutable
class TeritoriesInitial extends TeritoriesState {}

@immutable
class TeritoriesInitialLoaded extends TeritoriesState {
  final List<TeritoryModel> models;
  const TeritoriesInitialLoaded({this.models});
  @override
  List<Object> get props => [models];
}

@immutable
class TeritoriesDataChanged extends TeritoriesState {
  final List<TeritoryModel> models;
  const TeritoriesDataChanged({
    this.models,
  });
  @override
  List<Object> get props => [models];
}

@immutable
class TeritoriesSearchInvalid extends TeritoriesState {
  final String text;
  const TeritoriesSearchInvalid({this.text});
  @override
  List<Object> get props => [text];
}

@immutable
class TeritoriesEnd extends TeritoriesState {
  final String text;
  final List<TeritoryModel> models;
  const TeritoriesEnd({this.text, this.models});
  @override
  List<Object> get props => [text, models];
}

@immutable
class TeritoriesFiltered extends TeritoriesState {
  final List<TeritoryModel> models;
  const TeritoriesFiltered({this.models});
  @override
  List<Object> get props => [models];
}
