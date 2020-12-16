import 'package:aussie/interfaces/eventmanagement_notifs.dart';
import 'package:aussie/models/event/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventManagementSuccessNotification extends EventManagementNotification {}

class EventManagementErrorNotification extends EventManagementNotification {}

class EventModelsContainingNotification extends EventManagementNotification {
  final DocumentSnapshot prevsnap;
  final List<Map<String, dynamic>> eventModels;

  EventModelsContainingNotification({
    this.prevsnap,
    this.eventModels,
  });
}

class EventModelsContainingEndNotification extends EventManagementNotification {
  final List<Map<String, dynamic>> eventModels;

  EventModelsContainingEndNotification(this.eventModels);
}

class EventModelsContainingActualNotification
    extends EventManagementNotification {
  final List<EventModel> models;
  final DocumentSnapshot prevSnap;

  EventModelsContainingActualNotification(this.models, this.prevSnap);
}

class EventModelsContainingActualEndNotification
    extends EventManagementNotification {
  final List<EventModel> models;

  EventModelsContainingActualEndNotification(this.models);
}
