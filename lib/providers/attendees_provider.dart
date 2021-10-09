import 'dart:collection';


import 'package:aussie/providers/provider_notifications/attendees_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'provider_notifications/interfaces/iattendees_notifications.dart';

class AttendeesProvider {
  static final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  Future<IAttendeesNotification> fetchAttendees(
    String? eventId,
    DocumentSnapshot<Object?>? startAfter,
  ) async {
    Query<Object?> query;
    if (startAfter == null) {
      query = _firestoreInstance
          .collection('event')
          .doc(eventId)
          .collection('attendees')
          .orderBy('uid')
          .limit(10);
    } else {
      query = _firestoreInstance
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
      return AteendeesList(
        
        UnmodifiableListView<String>(uuids),
        querySnapshot.docs.last,
      );
    } else {
      return AteendeesEndList(
        UnmodifiableListView<String>(uuids),
      );
    }
  }
  Future<IAttendeesNotification> makeUserWithIdAttendEvent(
    String? uid,
    String? eventUuid,
  ) async {
    if (uid == null || eventUuid == null) {
      return const AttendingError();
    }
    try {
      final WriteBatch writeBatch = _firestoreInstance.batch();
      writeBatch.set(
        _firestoreInstance
            .collection('event')
            .doc(eventUuid)
            .collection('attendees')
            .doc(uid),
        <String, String?>{
          'uid': uid,
        },
      );
      writeBatch.update(
        _firestoreInstance.collection('users').doc(uid),
        <String, dynamic>{
          'attends': FieldValue.arrayUnion(<dynamic>[eventUuid])
        },
      );
      writeBatch.commit();
      return const AttendedEvent();
    } on FirebaseException {
      return const AttendingError();
    }
  }

  Future<IAttendeesNotification> makeUserWithIdUnAttendEvent(
      String uid, String eventUuid) async {
    try {
      final WriteBatch writeBatch = _firestoreInstance.batch();

      writeBatch.delete(
        _firestoreInstance
            .collection('event')
            .doc(eventUuid)
            .collection('attendees')
            .doc(uid),
      );
      writeBatch.update(
        _firestoreInstance.collection('users').doc(uid),
        <String, dynamic>{
          'attends': FieldValue.arrayRemove(<dynamic>[eventUuid])
        },
      );
      writeBatch.commit();
      return const UnAttendedEvent();
    } on FirebaseException {
      return const AttendingError();
    }
  }
}
