import 'package:aussie/models/event_attention_state/event_attention_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AttendeesRepository {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static CollectionReference<String> fetchAttendees(
    String? eventId,
  ) {
    return _firestoreInstance
        .collection('event/$eventId/attendees')
        .withConverter(
          fromFirestore: (snapshot, _) => snapshot['uuid'],
          toFirestore: (uid, _) => {'uid': uid},
        );
  }

  static Future<EventAttentionState> makeUserWithIdAttendEvent(
    String uid,
    String eventUuid,
  ) async {
   
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
      return const EventAttentionState.attended();
    } on FirebaseException {
      return const EventAttentionState.error();
    }
  }

  static Future<EventAttentionState> makeUserWithIdUnAttendEvent(
    String uid,
    String eventUuid,
  ) async {
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
      return const EventAttentionState.unattended();
    } on FirebaseException {
      return const EventAttentionState.error();
    }
  }
}
