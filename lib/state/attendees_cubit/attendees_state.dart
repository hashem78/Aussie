part of 'attendees_cubit.dart';

abstract class AttendeesState extends Equatable {
  const AttendeesState();

  @override
  List<Object> get props => <Object>[];
}

class AttendeesInitial extends AttendeesState {
  const AttendeesInitial();
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
