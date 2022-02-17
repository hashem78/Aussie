import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.g.dart';
part 'user_model.freezed.dart';

@freezed
class AussieUser with _$AussieUser {
  const factory AussieUser({
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
  factory AussieUser.fromJson(Map<String, dynamic> json) =>
      _$AussieUserFromJson(json);
}
