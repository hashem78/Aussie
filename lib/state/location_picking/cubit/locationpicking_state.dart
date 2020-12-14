part of 'locationpicking_cubit.dart';

abstract class LocationPickingState extends Equatable {
  const LocationPickingState(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class LocationPicked extends LocationPickingState {
  final LocationResult result;

  LocationPicked(this.result) : super(result.formattedAddress);
  @override
  List<Object> get props => [result];
}

class LocationNotPicked extends LocationPickingState {
  LocationNotPicked() : super("Location");
}
