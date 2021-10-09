import 'package:aussie/models/event/event_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'interfaces/ievent_management_notifications.dart';

class ESuccess extends IEMNotification {
  const ESuccess();
}

class EError extends IEMNotification {
  const EError();
}

class EModels extends IEMNotification {
  final DocumentSnapshot<Object?>? prevsnap;
  final List<Map<String, dynamic>>? eventModels;

  const EModels({
    this.prevsnap,
    this.eventModels,
  });
}

class EEnd extends IEMNotification {
  final List<Map<String, dynamic>> eventModels;

  const EEnd(this.eventModels);
}

class EActual extends IEMNotification {
  final List<EventModel> models;
  final DocumentSnapshot<Object?>? prevSnap;

  const EActual(this.models, this.prevSnap);
}

class EActualEnd extends IEMNotification {
  final List<EventModel> models;

  const EActualEnd(this.models);
}
