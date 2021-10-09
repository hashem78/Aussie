import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:aussie/providers/provider_notifications/interfaces/iattendees_notifications.dart';

class AttendedEvent extends IAttendeesNotification {
  const AttendedEvent();
}

class AttendingError extends IAttendeesNotification {
  const AttendingError();
}

class UnAttendedEvent extends IAttendeesNotification {
  const UnAttendedEvent();
}

class AteendeesList extends IAttendeesNotification {
  const AteendeesList(this.uuids, this.prevSnap);
  final UnmodifiableListView<String> uuids;
  final DocumentSnapshot<Object?> prevSnap;
}

class AteendeesEndList extends IAttendeesNotification {
  const AteendeesEndList(this.uuids);
  final UnmodifiableListView<String> uuids;
}
