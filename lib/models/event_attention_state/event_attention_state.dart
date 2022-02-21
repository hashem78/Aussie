import 'package:freezed_annotation/freezed_annotation.dart';
part 'event_attention_state.freezed.dart';

@freezed
class EventAttentionState with _$EventAttentionState {
  const factory EventAttentionState.attending() = _EventAttentionStateAttending;
  const factory EventAttentionState.attended() = _EventAttentionStateAttended;
  const factory EventAttentionState.unattended() =
      _EventAttentionStateUnAttended;
  const factory EventAttentionState.pending() = _EventAttentionStatePending;
  const factory EventAttentionState.error() = _EventAttentionStateError;
}
