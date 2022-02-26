import 'package:evento/models/location_picking_state/location_picking_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_picker/entities/entities.dart';

class LocationPickingNotifier extends StateNotifier<LocationPickingState> {
  LocationPickingNotifier() : super(const LocationPickingState.notPicked());
  void pick(LocationResult? newLoc) {
    if (newLoc != null) {
      state = LocationPickingState.picked(newLoc);
    } else {
      state = const LocationPickingState.error();
    }
  }

  bool validate() {
    return state.when(
      picked: (_) => true,
      notPicked: () {
        state = const LocationPickingState.error();
        return false;
      },
      error: () {
        state = const LocationPickingState.error();
        return false;
      },
    );
  }
}

final locationProvider = StateNotifierProvider.autoDispose<
    LocationPickingNotifier, LocationPickingState>(
  (_) {
    return LocationPickingNotifier();
  },
);
