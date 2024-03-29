part of 'attendees_cubit.dart';

abstract class AttendeesState extends Equatable {
  const AttendeesState();

  @override
  List<Object> get props => <Object>[];
}

class AttendeesInitial extends AttendeesState {
  const AttendeesInitial();
}

class AttendeesPerformingAction extends AttendeesState {
  const AttendeesPerformingAction();
}

class AttendeesAttended extends AttendeesState {
  const AttendeesAttended();
}

class AttendeesError extends AttendeesState {
  const AttendeesError(this.notification);
  final IAttendeesNotification notification;
}

class AttendeesActual extends AttendeesState {
  final List<String> uuids;

  const AttendeesActual(this.uuids);
  @override
  List<Object> get props => <Object>[uuids];
}

class AttendeesEmpty extends AttendeesState {
  const AttendeesEmpty();
}

class AttendeesActualEnd extends AttendeesState {
  final List<String> uuids;

  const AttendeesActualEnd(this.uuids);
  @override
  List<Object> get props => <Object>[uuids];
}
