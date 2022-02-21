import 'package:aussie/models/event/event_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scopedEventProvider = Provider.autoDispose<EventModel>(
  (_) {
    throw UnimplementedError();
  },
);
