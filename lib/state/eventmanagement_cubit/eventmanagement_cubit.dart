import 'package:aussie/models/event/event_model.dart';
import 'package:aussie/models/usermanagement/events/eventcreation_model.dart';
import 'package:aussie/repositories/eventmanagement_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:aussie/providers/provider_notifications/provider_notifications.dart';
part 'eventmanagement_state.dart';

class EMCubit extends Cubit<EMCState> {
  EMCubit() : super(const EMCInitial());
  final EventManagementRepository _repository = EventManagementRepository();

  void refresh() {
    prevSnap = null;
    emit(const EMCInitial());
  }

  DocumentSnapshot<Object?>? prevSnap;
  void addEvent(EventCreationModel model) {
    emit(const EMCPerformingAction());
    _repository.addUserEvent(model).then(
      (IEMNotification value) {
        if (value is ESuccess) {
          emit(const EMCCreated());
        } else {
          emit(const EMCError());
        }
      },
    );
  }

  void fetchEventsForUser({
    required String uid,
    DocumentSnapshot<Object?>? lastdoc,
  }) {
    _repository.fetchEventsForUser(uid, lastdoc).then(
      (
        IEMNotification value,
      ) {
        if (value is EActual) {
          prevSnap = value.prevSnap;
          emit(EMCEventsFetched(value.models));
        } else if (value is EActualEnd) {
          emit(EMCEndEventsFetched(value.models));
        }
      },
    );
  }

  void fetchPublicEvents({DocumentSnapshot<Object?>? lastdoc}) {
    _repository.fetchPublicEvents(lastdoc).then(
      (IEMNotification value) {
        if (value is EActual) {
          prevSnap = value.prevSnap;
          emit(EMCEventsFetched(value.models));
        } else if (value is EActualEnd) {
          emit(EMCEndEventsFetched(value.models));
        }
      },
    );
  }

  void emitInitial() {
    emit(const EMCInitial());
  }

  bool validate(dynamic data) {
    return data == null || data == '';
  }
}
