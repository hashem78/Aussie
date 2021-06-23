import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:place_picker/entities/location_result.dart';

part 'locationpicking_state.dart';

class LocationPickingCubit extends Cubit<LocationPickingState> {
  LocationPickingCubit() : super(const LocationNotPicked());

  void pickLoc(LocationResult? result) {
    if (result == null) {
      emit(const LocationNotPicked());
    } else {
      emit(LocationPicked(result));
    }
  }

  LocationResult? get value {
    final LocationPickingState _currentState = state;
    if (_currentState is LocationPicked) {
      return _currentState.result;
    } else {
      return null;
    }
  }
}
