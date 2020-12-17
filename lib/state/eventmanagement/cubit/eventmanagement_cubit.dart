import 'package:aussie/models/event/event.dart';
import 'package:aussie/models/usermanagement/eventmanagement_notifs.dart';
import 'package:aussie/models/usermanagement/events/creation/eventcreation_model.dart';
import 'package:aussie/repositories/eventmanagement.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:place_picker/entities/entities.dart';

part 'eventmanagement_state.dart';

class EventManagementCubit extends Cubit<EventManagementState> {
  EventManagementCubit() : super(EventmanagementInitial());
  EventManagementRepository _repository = EventManagementRepository();

  void refresh() {
    prevSnap = null;
    emit(EventmanagementInitial());
  }

  DocumentSnapshot prevSnap;
  void addEvent(EventCreationModel model) {
    emit(EventManagementPerformingAction());
    _repository.addEvent(model).then(
      (value) {
        if (value is EventManagementSuccessNotification) {
          emit(EventManagementCreated());
        } else {
          emit(EventManagementError(""));
        }
      },
    );
  }

  void fetchEvents({DocumentSnapshot lastdoc}) {
    _repository.fetchEvents(lastdoc).then(
      (value) {
        if (value is EventModelsContainingActualNotification) {
          prevSnap = value.prevSnap;
          emit(EventManagementEventsFetched(value.models));
        } else if (value is EventModelsContainingActualEndNotification) {
          emit(EventManagementEndEventsFetched(value.models));
        }
      },
    );
  }

  void validateLocation(LocationResult result, String errorText) {
    if (result == null) {
      emit(EventManagementError(errorText));
    } else
      emitValid();
  }

  void validateMultiImage(List<ByteData> data, String errorText) {
    if (data == null)
      emit(EventManagementError(errorText));
    else
      emitValid();
  }

  void validateSingleImage(ByteData data, String errorText) {
    if (data == null)
      emit(EventManagementError(errorText));
    else
      emitValid();
  }

  void emitValid() {
    emit(EvenetManagmentAllGood());
  }
}
