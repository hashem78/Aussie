part of 'locationpicking_cubit.dart';

abstract class LocationPickingState extends Equatable {
  const LocationPickingState(this.message);
  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}

class LocationPicked extends LocationPickingState {
  final LocationResult result;

  LocationPicked(this.result) : super(result.formattedAddress ?? '');
  @override
  List<Object> get props => <Object>[result];
}

class LocationNotPicked extends LocationPickingState {
  const LocationNotPicked() : super('locationStateInitial');
}
