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
  String get eventsCollectionPath => "users/$uid/events";
  String get attendeesCollectionPath => "users/$uid/foreign/attendees";
  String get galleryCollectionPath => "users/$uid/foreign/gallery";
  final String uid;
  final String displayName;
  final String email;
  final bool emailVerified;
  final String username;
  final String fullname;

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
