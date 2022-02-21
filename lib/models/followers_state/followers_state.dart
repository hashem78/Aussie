import 'package:freezed_annotation/freezed_annotation.dart';

part 'followers_state.freezed.dart';

@freezed
class FollowersState with _$FollowersState {
  const factory FollowersState.userIsFollowed() = _FollowersStateUserIsFollowed;
  const factory FollowersState.userIsNotFollowed() = _FollowersStateUserIsNotFollowed;
  const factory FollowersState.determiningState() = _FollowersStateDeterminingState;
  
  const factory FollowersState.error() = _FollowersStateError;
}
