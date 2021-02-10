import 'package:aussie/models/usermanagement/events/eventmanagement_notifs.dart';
import 'package:aussie/repositories/attendees_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'attendees_state.dart';

class AttendeesCubit extends Cubit<AttendeesState> {
  AttendeesCubit() : super(const AttendeesInitial());
  final AttendeesRepository _repository = AttendeesRepository();
  DocumentSnapshot prevsnap;
  Future<void> fetchAttendees(String eventId) async {
    final notif = await _repository.fetchAttendees(eventId, prevsnap);

    if (notif is AttendeesNotification) {
      if (notif.uuids.isEmpty && prevsnap == null) {
        emit(const AttendeesEmpty());
      } else {
        emit(AttendeesActual(notif.uuids));
        prevsnap = notif.prevsnap;
      }
    } else if (notif is AttendeesEndNotification) {
      emit(AttendeesActualEnd(notif.uuids));
    }
  }

  void reset() {
    prevsnap = null;
    emit(const AttendeesInitial());
  }
}
