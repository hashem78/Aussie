import 'package:aussie/interfaces/eventmanagement_notifs.dart';
import 'package:aussie/models/event/event_model.dart';
import 'package:aussie/models/usermanagement/events/eventcreation_model.dart';
import 'package:aussie/models/usermanagement/events/eventmanagement_notifs.dart';
import 'package:aussie/providers/eventmanagment_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventManagementRepository {
  final EventManagementProvider _provider = EventManagementProvider();
  Future<EventManagementNotification> addUserEvent(EventCreationModel model) {
    return _provider.addEvent(model);
  }

  Future<EventManagementNotification> fetchEventsForUser(
    String uid,
    DocumentSnapshot<Object?>? prevSnap,
  ) async {
    final EventManagementNotification notification =
        await _provider.fetchEventsForUser(uid, prevSnap);
    if (notification is EventModelsNotification) {
      final List<EventModel> models = <EventModel>[];
      for (final Map<String, dynamic> element in notification.eventModels!) {
        models.add(EventModel.fromJson(element));
      }
      return EventsActualNotification(
        models,
        notification.prevsnap,
      );
    } else if (notification is EventsEndNotification) {
      final List<EventModel> models = <EventModel>[];
      for (final Map<String, dynamic> element in notification.eventModels) {
        models.add(EventModel.fromJson(element));
      }
      return EventsActualEndNotification(models);
    } else {
      return notification;
    }
  }

  Future<EventManagementNotification> fetchPublicEvents(
    DocumentSnapshot<Object?>? prevSnap,
  ) async {
    final EventManagementNotification notification =
        await _provider.fetchPublicEvents(prevSnap);
    if (notification is EventModelsNotification) {
      final List<EventModel> models = <EventModel>[];
      for (final Map<String, dynamic> element in notification.eventModels!) {
        models.add(EventModel.fromJson(element));
      }
      return EventsActualNotification(
        models,
        notification.prevsnap,
      );
    } else if (notification is EventsEndNotification) {
      final List<EventModel> models = <EventModel>[];
      for (final Map<String, dynamic> element in notification.eventModels) {
        models.add(EventModel.fromJson(element));
      }
      return EventsActualEndNotification(models);
    } else {
      return notification;
    }
  }
}
