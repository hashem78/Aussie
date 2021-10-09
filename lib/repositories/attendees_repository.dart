import 'package:aussie/providers/attendees_provider.dart';
import 'package:aussie/providers/provider_notifications/provider_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendeesRepository {
  final AttendeesProvider _provider = AttendeesProvider();
  Future<IEMNotification> fetchAttendees(
    String? eventId,
    DocumentSnapshot<Object?>? prevsnap,
  ) async {
    return _provider.fetchAttendees(eventId, prevsnap);
  }
}
