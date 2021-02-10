import 'dart:collection';

import 'package:aussie/interfaces/eventmanagement_notifs.dart';
import 'package:aussie/models/usermanagement/events/eventmanagement_notifs.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AttendeesProvider {
  static final _firestore = FirebaseFirestore.instance;
  Future<EventManagementNotification> fetchAttendees(
    String eventId,
    DocumentSnapshot startAfter,
  ) async {
    Query query;
    if (startAfter == null) {
      query = _firestore
          .collection("event")
          .doc(eventId)
          .collection("attendees")
          .orderBy("uid")
          .limit(10);
    } else {
      query = _firestore
          .collection("event")
          .doc(eventId)
          .collection("attendees")
          .orderBy("uid")
          .limit(10)
          .startAfterDocument(startAfter);
    }
    final QuerySnapshot querySnapshot = await query.get();
    final List<String> uuids = List<String>.from(
      querySnapshot.docs
          .map(
            (e) => e.get('uid') as String,
          )
          .toList(),
    );

    if (uuids.length >= 10) {
      return AttendeesNotification(
        querySnapshot.docs.last,
        UnmodifiableListView(uuids),
      );
    } else {
      return AttendeesEndNotification(
        UnmodifiableListView(uuids),
      );
    }
  }
}
