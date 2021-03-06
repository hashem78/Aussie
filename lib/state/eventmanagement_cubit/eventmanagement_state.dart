part of 'eventmanagement_cubit.dart';

abstract class EventManagementState extends Equatable {
  const EventManagementState();

  @override
  List<Object> get props => [];
}

class EventmanagementInitial extends EventManagementState {}

class EventManagementPerformingAction extends EventManagementState {}

class EventManagementCreated extends EventManagementState {}

class EventManagementError extends EventManagementState {
  const EventManagementError();
}

class EventManagementEventsFetched extends EventManagementState {
  final List<EventModel> models;

  const EventManagementEventsFetched(this.models);
  @override
  List<Object> get props => [models];
}

class EventManagementEndEventsFetched extends EventManagementState {
  final List<EventModel> models;

  const EventManagementEndEventsFetched(this.models);
  @override
  List<Object> get props => [models];
}
