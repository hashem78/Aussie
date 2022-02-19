import 'package:freezed_annotation/freezed_annotation.dart';
part 'event_state.freezed.dart';

@freezed
class EventState with _$EventState {
  const factory EventState.sucess() = _EventStateSuccess;
  const factory EventState.error() = _EventStateError;
}
