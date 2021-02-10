import 'package:aussie/interfaces/eventmanagement_notifs.dart';
import 'package:aussie/models/event/event_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SuccessNotification extends EventManagementNotification {
  const SuccessNotification();
}

class ErrorNotification extends EventManagementNotification {
  const ErrorNotification();
}

class EventModelsNotification extends EventManagementNotification {
  final DocumentSnapshot prevsnap;
  final List<Map<String, dynamic>> eventModels;

  const EventModelsNotification({
    this.prevsnap,
    this.eventModels,
  });
}

class AttendeesNotification extends EventManagementNotification {
  final DocumentSnapshot prevsnap;
  final List<String> uuids;

  const AttendeesNotification(this.prevsnap, this.uuids);
}

class EventsEndNotification extends EventManagementNotification {
  final List<Map<String, dynamic>> eventModels;

  const EventsEndNotification(this.eventModels);
}

class AttendeesEndNotification extends EventManagementNotification {
  final List<String> uuids;
  const AttendeesEndNotification(this.uuids);
}

class EventsActualNotification extends EventManagementNotification {
  final List<EventModel> models;
  final DocumentSnapshot prevSnap;

  const EventsActualNotification(this.models, this.prevSnap);
}

class EventsActualEndNotification extends EventManagementNotification {
  final List<EventModel> models;

  const EventsActualEndNotification(this.models);
}
