part of 'dyk_cubit.dart';

@immutable
abstract class DykState extends Equatable {
  const DykState();

  @override
  List<Object> get props => [];
}

class DykInitial extends DykState {}

class DykLoading extends DykState {}

class DykLoaded extends DykState {
  final List<DYKModel> models;
  DykLoaded(this.models);
}
