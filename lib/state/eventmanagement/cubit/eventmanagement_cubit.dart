import 'package:aussie/models/usermanagement/eventmanagement_notifs.dart';
import 'package:aussie/models/usermanagement/events/creation/eventcreation_model.dart';
import 'package:aussie/repositories/eventmanagement.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'eventmanagement_state.dart';

class EventmanagementCubit extends Cubit<EventmanagementState> {
  EventmanagementCubit() : super(EventmanagementInitial());
  EventManagementRepository _repository = EventManagementRepository();
  void addEvent(EventCreationModel model) {
    emit(EventmanagementPerformingAction());
    _repository.addEvent(model).then(
      (value) {
        if (value is EventManagementSuccessNotification) {
          emit(EventmanagementCreated());
        } else {
          emit(EventmanagementError());
        }
      },
    );
  }
}
