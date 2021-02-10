import 'package:aussie/interfaces/eventmanagement_notifs.dart';
import 'package:aussie/providers/attendees_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendeesRepository {
  final AttendeesProvider _provider = AttendeesProvider();
  Future<EventManagementNotification> fetchAttendees(
    String eventId,
    DocumentSnapshot prevsnap,
  ) async {
    return _provider.fetchAttendees(eventId, prevsnap);
  }
}
