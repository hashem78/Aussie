part of 'aussiepaginated_cubit.dart';

class AussiePaginatedInitial extends AussiePaginatedState {}

abstract class AussiePaginatedState extends Equatable {
  const AussiePaginatedState();

  @override
  List<Object> get props => [];
}

class AussiePaginatedInitialLoaded extends AussiePaginatedState {
  final List<PaginatedDataModel> models;
  const AussiePaginatedInitialLoaded({this.models});
  @override
  List<Object> get props => [models];
}

class AussiePaginatedDataChanged extends AussiePaginatedState {
  final List<PaginatedDataModel> models;
  const AussiePaginatedDataChanged({
    this.models,
  });
  @override
  List<Object> get props => [models];
}

class AussiePaginatedSearchInvalid extends AussiePaginatedState {
  final String text;
  const AussiePaginatedSearchInvalid({this.text});
  @override
  List<Object> get props => [text];
}

class AussiePaginatedEnd extends AussiePaginatedState {
  final String text;
  final List<PaginatedDataModel> models;
  const AussiePaginatedEnd({this.text, this.models});
  @override
  List<Object> get props => [text, models];
}

class AussiePaginatedFiltered extends AussiePaginatedState {
  final List<PaginatedDataModel> models;
  const AussiePaginatedFiltered({this.models});
  @override
  List<Object> get props => [models];
}
