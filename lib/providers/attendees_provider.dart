import 'dart:collection';

import 'package:aussie/models/usermanagement/events/eventmanagement_notifs.dart';
import 'package:aussie/providers/provider_notifications/interfaces/ievent_management_notifications.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AttendeesProvider {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<IEMNotification> fetchAttendees(
    String? eventId,
    DocumentSnapshot<Object?>? startAfter,
  ) async {
    Query<Object?> query;
    if (startAfter == null) {
      query = _firestore
          .collection('event')
          .doc(eventId)
          .collection('attendees')
          .orderBy('uid')
          .limit(10);
    } else {
      query = _firestore
          .collection('event')
          .doc(eventId)
          .collection('attendees')
          .orderBy('uid')
          .limit(10)
          .startAfterDocument(startAfter);
    }
    final QuerySnapshot<Object?> querySnapshot = await query.get();
    final List<String> uuids = List<String>.from(
      querySnapshot.docs
          .map(
            (QueryDocumentSnapshot<Object?> e) => e.get('uid') as String?,
          )
          .toList(),
    );

    if (uuids.length >= 10) {
      return AttendeesNotification(
        querySnapshot.docs.last,
        UnmodifiableListView<String>(uuids),
      );
    } else {
      return AttendeesEndNotification(
        UnmodifiableListView<String>(uuids),
      );
    }
  }
}
