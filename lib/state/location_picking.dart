import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_picker/entities/entities.dart';

class LocationPickingNotifier extends StateNotifier<LocationResult?> {
  LocationPickingNotifier() : super(null);
  void changeTo(LocationResult? newLoc) {
    state = newLoc;
  }
}

final locationProvider =
    StateNotifierProvider.autoDispose<LocationPickingNotifier, LocationResult?>(
  (_) {
    return LocationPickingNotifier();
  },
);
