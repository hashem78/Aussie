part of 'efe_cubit.dart';

@immutable
abstract class EFEState extends Equatable {
  const EFEState(this.models);
  final List<MainScreenDetailsModel> models;
  @override
  List<Object> get props => [models];
}

class EFEInitial extends EFEState {
  EFEInitial() : super([]);
}

class EFEDataChanged extends EFEState {
  EFEDataChanged(models) : super(models);
  @override
  List<Object> get props => [models];
}

class EFELoading extends EFEState {
  EFELoading() : super([]);
}
