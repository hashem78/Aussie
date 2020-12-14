part of 'eventmanagement_cubit.dart';

abstract class EventmanagementState extends Equatable {
  const EventmanagementState();

  @override
  List<Object> get props => [];
}

class EventmanagementInitial extends EventmanagementState {}

class EventmanagementPerformingAction extends EventmanagementState {}

class EventmanagementCreated extends EventmanagementState {}

class EventmanagementError extends EventmanagementState {}
