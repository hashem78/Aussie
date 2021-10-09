part of 'eventmanagement_cubit.dart';

abstract class EMCState extends Equatable {
  const EMCState();

  @override
  List<Object> get props => <Object>[];
}

class EMCInitial extends EMCState {}

class EMCPerformingAction extends EMCState {}

class EMCCreated extends EMCState {}

class EMCError extends EMCState {
  const EMCError();
}

class EMCEventsFetched extends EMCState {
  final List<EventModel> models;

  const EMCEventsFetched(this.models);
  @override
  List<Object> get props => <Object>[models];
}

class EMCEndEventsFetched extends EMCState {
  final List<EventModel> models;

  const EMCEndEventsFetched(this.models);
  @override
  List<Object> get props => <Object>[models];
}
