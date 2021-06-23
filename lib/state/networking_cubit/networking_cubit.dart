import 'package:bloc/bloc.dart';

part 'networking_state.dart';

class NetworkingCubit extends Cubit<NetworkingState> {
  NetworkingCubit() : super(const NetworkingInitial());
  void emitAvail() {
    emit(const NetworkingAvailable());
  }

  void emitUnavail() {
    emit(const NetworkingUnavailable());
  }
}
