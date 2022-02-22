import 'package:place_picker/entities/entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'location_picking_state.freezed.dart';

@freezed
class LocationPickingState with _$LocationPickingState {
  const factory LocationPickingState.picked(LocationResult locationResult) =
      _LocationPickingStatePicked;
  const factory LocationPickingState.notPicked() =
      _LocationPickingStateNotPicked;
  const factory LocationPickingState.error() = _LocationPickingStateError;
}
