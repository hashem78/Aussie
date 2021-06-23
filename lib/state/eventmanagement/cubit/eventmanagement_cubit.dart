import 'package:aussie/models/event/event_model.dart';
import 'package:aussie/models/usermanagement/events/eventcreation_model.dart';
import 'package:aussie/models/usermanagement/events/eventmanagement_notifs.dart';
import 'package:aussie/repositories/eventmanagement_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'eventmanagement_state.dart';

class EventManagementCubit extends Cubit<EventManagementState> {
  EventManagementCubit() : super(EventmanagementInitial());
  final EventManagementRepository _repository = EventManagementRepository();

  void refresh() {
    prevSnap = null;
    emit(EventmanagementInitial());
  }

  DocumentSnapshot? prevSnap;
  void addEvent(EventCreationModel model) {
    emit(EventManagementPerformingAction());
    _repository.addUserEvent(model).then(
      (value) {
        if (value is SuccessNotification) {
          emit(EventManagementCreated());
        } else {
          emit(const EventManagementError());
        }
      },
    );
  }

  void fetchUserEvents({DocumentSnapshot? lastdoc}) {
    _repository.fetchUserEvents(lastdoc).then(
      (value) {
        if (value is EventsActualNotification) {
          prevSnap = value.prevSnap;
          emit(EventManagementEventsFetched(value.models));
        } else if (value is EventsActualEndNotification) {
          emit(EventManagementEndEventsFetched(value.models));
        }
      },
    );
  }

  void fetchPublicEvents({DocumentSnapshot? lastdoc}) {
    _repository.fetchPublicEvents(lastdoc).then(
      (value) {
        if (value is EventsActualNotification) {
          prevSnap = value.prevSnap;
          emit(EventManagementEventsFetched(value.models));
        } else if (value is EventsActualEndNotification) {
          emit(EventManagementEndEventsFetched(value.models));
        }
      },
    );
  }

  void emitInitial() {
    emit(EventmanagementInitial());
  }

  bool validate(dynamic data) {
    return data == null || data == "";
  }
}
