import 'package:aussie/models/event/event_model.dart';
import 'package:aussie/models/usermanagement/user/user_model.dart';
import 'package:aussie/providers/provider_notifications/attendees_notifications.dart';
import 'package:aussie/providers/provider_notifications/interfaces/iattendees_notifications.dart';
import 'package:aussie/repositories/attendees_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'attendees_state.dart';

class AttendeesCubit extends Cubit<AttendeesState> {
  AttendeesCubit() : super(const AttendeesInitial());
  final AttendeesRepository _repository = AttendeesRepository();
  DocumentSnapshot<Object?>? prevsnap;
  Future<void> fetchAttendees(String? eventId) async {
    final IAttendeesNotification notif =
        await _repository.fetchAttendees(eventId, prevsnap);

    if (notif is AteendeesList) {
      if (notif.uuids.isEmpty && prevsnap == null) {
        emit(const AttendeesEmpty());
      } else {
        emit(AttendeesActual(notif.uuids));
        prevsnap = notif.prevSnap;
      }
    } else if (notif is AteendeesEndList) {
      emit(AttendeesActualEnd(notif.uuids));
    }
  }

  void makeUserWithIdAttendEvent(AussieUser user, String? eventUuid) {
    emit(const AttendeesPerformingAction());

    _repository
        .makeUserWithIdAttendEvent(
      user.uid,
      eventUuid,
    )
        .then(
      (IAttendeesNotification value) {
        if (value is AttendedEvent) {
          emit(const AttendeesAttended());
        } else {
          emit(AttendeesError(value));
        }
      },
    );
  }

  void isUserAttending(AussieUser user, EventModel eventModel) {
    if (user.attends!.contains(eventModel.eventId)) {
      emit(const AttendeesAttended());
    }
  }

  void reset() {
    prevsnap = null;
    emit(const AttendeesInitial());
  }
}
