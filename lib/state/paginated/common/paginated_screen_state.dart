import 'package:aussie/interfaces/paginated_data_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class PaginatedScreenState extends Equatable {
  const PaginatedScreenState();

  @override
  List<Object> get props => [];
}

@immutable
class PaginatedScreenInitial extends PaginatedScreenState {}

@immutable
class PaginatedScreenInitialLoaded extends PaginatedScreenState {
  final List<PaginatedDataModel> models;
  const PaginatedScreenInitialLoaded({this.models});
  @override
  List<Object> get props => [models];
}

@immutable
class PaginatedScreenDataChanged extends PaginatedScreenState {
  final List<PaginatedDataModel> models;
  const PaginatedScreenDataChanged({
    this.models,
  });
  @override
  List<Object> get props => [models];
}

@immutable
class PaginatedScreenSearchInvalid extends PaginatedScreenState {
  final String text;
  const PaginatedScreenSearchInvalid({this.text});
  @override
  List<Object> get props => [text];
}

@immutable
class PaginatedScreenEnd extends PaginatedScreenState {
  final String text;
  final List<PaginatedDataModel> models;
  const PaginatedScreenEnd({this.text, this.models});
  @override
  List<Object> get props => [text, models];
}

@immutable
class PaginatedScreenFiltered extends PaginatedScreenState {
  final List<PaginatedDataModel> models;
  const PaginatedScreenFiltered({this.models});
  @override
  List<Object> get props => [models];
}
