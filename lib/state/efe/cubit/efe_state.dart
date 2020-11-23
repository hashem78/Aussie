part of 'efe_cubit.dart';

@immutable
abstract class EFEState extends Equatable {
  const EFEState();

  @override
  List<Object> get props => [];
}

class EFEInitial extends EFEState {}

class EFEDataChanged extends EFEState {
  final List<MainScreenDetailsModel> models;
  EFEDataChanged(this.models);
  @override
  List<Object> get props => [models];
}

class EFELoading extends EFEState {}
