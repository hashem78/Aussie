import 'package:freezed_annotation/freezed_annotation.dart';

part 'followers_state.freezed.dart';
@freezed
class FollowersState with _$FollowersState{
  const factory FollowersState.followedUser() = _FollowersStateFollowedUser;
  const factory FollowersState.unFollowedUser() = _FollowersStateUnFollowedUser;
  const factory FollowersState.error() = _FollowersStateError;
}