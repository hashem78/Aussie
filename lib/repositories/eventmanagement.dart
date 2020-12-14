import 'package:aussie/interfaces/eventmanagement_notifs.dart';

import 'package:aussie/models/usermanagement/events/creation/eventcreation_model.dart';
import 'package:aussie/providers/eventmanagment.dart';

class EventManagementRepository {
  EventManagementProvider _provider = EventManagementProvider();
  Future<EventManagementNotification> addEvent(EventCreationModel model) {
    return _provider.addEvent(model);
  }
}
