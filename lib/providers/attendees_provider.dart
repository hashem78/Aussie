import 'dart:collection';


import 'package:cloud_firestore/cloud_firestore.dart';

import 'provider_notifications/provider_notifications.dart';

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
      return EAttendees(
        querySnapshot.docs.last,
        UnmodifiableListView<String>(uuids),
      );
    } else {
      return EAttendeesEnd(
        UnmodifiableListView<String>(uuids),
      );
    }
  }
}
