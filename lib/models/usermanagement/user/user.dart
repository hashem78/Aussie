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
  final String uid;
  final String displayName;
  final String email;
  final bool emailVerified;

  final String profilePictureLink;
  final String profileBanner;
  factory AussieUser.fromJson(Map<String, dynamic> json) =>
      _$AussieUserFromJson(json);
  Map<String, dynamic> toJson() => _$AussieUserToJson(this);

  AussieUser({
    this.uid,
    this.displayName,
    this.email,
    this.emailVerified,
    this.profilePictureLink,
    this.profileBanner,
  });
}
