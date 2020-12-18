import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(
  createFactory: true,
  createToJson: true,
  checked: true,
)
@immutable
class AussieUser {
  final String displayName;
  final String email;
  final bool emailVerified;
  final String username;
  final String fullname;

  @JsonKey()
  final String uid;

  @JsonKey(defaultValue: const [])
  final List<String> attends;
  @JsonKey(defaultValue: 0)
  final int numberOfFollowers;
  @JsonKey(defaultValue: 0)
  final int numberOfFollowing;
  @JsonKey(defaultValue: 0)
  final int numberOfPosts;

  @JsonKey(defaultValue: "")
  final String profilePictureLink;
  @JsonKey(defaultValue: "")
  final String profileBannerLink;
  factory AussieUser.fromJson(Map<String, dynamic> json) =>
      _$AussieUserFromJson(json);
  Map<String, dynamic> toJson() => _$AussieUserToJson(this);

  const AussieUser({
    this.uid,
    this.attends,
    this.displayName,
    this.email,
    this.emailVerified,
    this.username,
    this.numberOfFollowers,
    this.numberOfFollowing,
    this.numberOfPosts,
    this.profilePictureLink,
    this.profileBannerLink,
    this.fullname,
  });
}
