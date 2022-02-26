import 'package:evento/models/auth_state/auth_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.g.dart';
part 'user_model.freezed.dart';

@freezed
class AussieUser with _$AussieUser {
  const factory AussieUser.signedIn({
    required String? displayName,
    required String email,
    required bool? emailVerified,
    required String username,
    required String fullname,
    required String uid,
    required List<String>? attends,
    required int numberOfFollowers,
    required int numberOfFollowing,
    required int numberOfPosts,
    required String profilePictureLink,
    required String profileBannerLink,
  }) = _AussieUser;
  const factory AussieUser.firstRun() = _AusssieUserFirstRun;
  const factory AussieUser.signedOut() = _AusssieUserSignedOut;

  const factory AussieUser.error({
    @JsonKey(ignore: true) AuthState? errorState,
  }) = _AusssieUserError;
  factory AussieUser.fromJson(Map<String, dynamic> json) =>
      _$AussieUserFromJson(json);
}
