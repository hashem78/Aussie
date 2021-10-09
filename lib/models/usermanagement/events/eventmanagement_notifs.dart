import 'package:aussie/models/event/event_model.dart';
import 'package:aussie/providers/provider_notifications/interfaces/provider_notifications_interfaces.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SuccessNotification extends IEMNotification {
  const SuccessNotification();
}

class ErrorNotification extends IEMNotification {
  const ErrorNotification();
}

class EventModelsNotification extends IEMNotification {
  final DocumentSnapshot<Object?>? prevsnap;
  final List<Map<String, dynamic>>? eventModels;

  const EventModelsNotification({
    this.prevsnap,
    this.eventModels,
  });
}

class AttendeesNotification extends IEMNotification {
  final DocumentSnapshot<Object?> prevsnap;
  final List<String> uuids;

  const AttendeesNotification(this.prevsnap, this.uuids);
}

class EventsEndNotification extends IEMNotification {
  final List<Map<String, dynamic>> eventModels;

  const EventsEndNotification(this.eventModels);
}

class AttendeesEndNotification extends IEMNotification {
  final List<String> uuids;
  const AttendeesEndNotification(this.uuids);
}

class EventsActualNotification extends IEMNotification {
  final List<EventModel> models;
  final DocumentSnapshot<Object?>? prevSnap;

  const EventsActualNotification(this.models, this.prevSnap);
}

class EventsActualEndNotification extends IEMNotification {
  final List<EventModel> models;

  const EventsActualEndNotification(this.models);
}
