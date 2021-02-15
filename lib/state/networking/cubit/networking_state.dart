part of 'networking_cubit.dart';

abstract class NetworkingState {
  const NetworkingState();
}

class NetworkingInitial extends NetworkingState {
  const NetworkingInitial();
}

class NetworkingAvailable extends NetworkingState {
  const NetworkingAvailable();
}

class NetworkingUnavailable extends NetworkingState {
  const NetworkingUnavailable();
}
