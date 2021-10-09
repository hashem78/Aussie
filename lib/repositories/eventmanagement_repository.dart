import 'package:aussie/models/event/event_model.dart';
import 'package:aussie/models/usermanagement/events/eventcreation_model.dart';
import 'package:aussie/providers/eventmanagment_provider.dart';
import 'package:aussie/providers/provider_notifications/provider_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventManagementRepository {
  final EventManagementProvider _provider = EventManagementProvider();
  Future<IEMNotification> addUserEvent(EventCreationModel model) {
    return _provider.addEvent(model);
  }

  Future<IEMNotification> fetchEventsForUser(
    String uid,
    DocumentSnapshot<Object?>? prevSnap,
  ) async {
    final IEMNotification notification =
        await _provider.fetchEventsForUser(uid, prevSnap);
    if (notification is EModels) {
      final List<EventModel> models = <EventModel>[];
      for (final Map<String, dynamic> element in notification.eventModels!) {
        models.add(EventModel.fromJson(element));
      }
      return EActual(
        models,
        notification.prevsnap,
      );
    } else if (notification is EEnd) {
      final List<EventModel> models = <EventModel>[];
      for (final Map<String, dynamic> element in notification.eventModels) {
        models.add(EventModel.fromJson(element));
      }
      return EActualEnd(models);
    } else {
      return notification;
    }
  }

  Future<IEMNotification> fetchPublicEvents(
    DocumentSnapshot<Object?>? prevSnap,
  ) async {
    final IEMNotification notification =
        await _provider.fetchPublicEvents(prevSnap);
    if (notification is EModels) {
      final List<EventModel> models = <EventModel>[];
      for (final Map<String, dynamic> element in notification.eventModels!) {
        models.add(EventModel.fromJson(element));
      }
      return EActual(
        models,
        notification.prevsnap,
      );
    } else if (notification is EEnd) {
      final List<EventModel> models = <EventModel>[];
      for (final Map<String, dynamic> element in notification.eventModels) {
        models.add(EventModel.fromJson(element));
      }
      return EActualEnd(models);
    } else {
      return notification;
    }
  }
}
