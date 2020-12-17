import 'package:aussie/interfaces/eventmanagement_notifs.dart';
import 'package:aussie/models/event/event.dart';
import 'package:aussie/models/usermanagement/eventmanagement_notifs.dart';

import 'package:aussie/models/usermanagement/events/creation/eventcreation_model.dart';
import 'package:aussie/providers/eventmanagment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventManagementRepository {
  EventManagementProvider _provider = EventManagementProvider();
  Future<EventManagementNotification> addUserEvent(EventCreationModel model) {
    return _provider.addEvent(model);
  }

  Future<EventManagementNotification> fetchUserEvents(
    DocumentSnapshot prevSnap,
  ) async {
    EventManagementNotification notification =
        await _provider.fetchUserEvents(prevSnap);
    if (notification is EventModelsContainingNotification) {
      List<EventModel> models = [];
      notification.eventModels.forEach(
        (element) {
          models.add(EventModel.fromJson(element));
        },
      );
      return EventModelsContainingActualNotification(
        models,
        notification.prevsnap,
      );
    } else if (notification is EventModelsContainingEndNotification) {
      List<EventModel> models = [];
      notification.eventModels.forEach(
        (element) {
          models.add(EventModel.fromJson(element));
        },
      );
      return EventModelsContainingActualEndNotification(models);
    } else {
      return notification;
    }
  }
}
