part of 'paginated_cubit.dart';

abstract class PaginatedState extends Equatable {
  final List<IPaginatedData> models;
  const PaginatedState(this.models);

  @override
  List<Object> get props => <Object>[models];
}

class PaginatedInitial extends PaginatedState {
  const PaginatedInitial() : super(const <IPaginatedData>[]);
}

class PaginatedInitialLoaded extends PaginatedState {
  const PaginatedInitialLoaded(List<IPaginatedData> models) : super(models);
}

class PaginatedDataChanged extends PaginatedState {
  const PaginatedDataChanged(List<IPaginatedData> models) : super(models);
}

class PaginatedEnd extends PaginatedState {
  const PaginatedEnd(List<IPaginatedData> models) : super(models);
}

class PaginatedFiltered extends PaginatedState {
  const PaginatedFiltered(List<IPaginatedData> models) : super(models);
}
