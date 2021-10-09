import 'package:aussie/providers/attendees_provider.dart';
import 'package:aussie/providers/provider_notifications/interfaces/iattendees_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendeesRepository {
  final AttendeesProvider _provider = AttendeesProvider();
  Future<IAttendeesNotification> fetchAttendees(
    String? eventId,
    DocumentSnapshot<Object?>? prevsnap,
  ) async {
    return _provider.fetchAttendees(eventId, prevsnap);
  }

  Future<IAttendeesNotification> makeUserWithIdAttendEvent(
      String? uid, String? eventUuid) async {
    return _provider.makeUserWithIdAttendEvent(uid, eventUuid);
  }
}
