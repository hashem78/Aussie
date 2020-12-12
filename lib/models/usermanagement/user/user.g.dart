// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AussieUser _$AussieUserFromJson(Map<String, dynamic> json) {
  return $checkedNew('AussieUser', json, () {
    final val = AussieUser(
      uid: $checkedConvert(json, 'uid', (v) => v as String),
      displayName: $checkedConvert(json, 'displayName', (v) => v as String),
      email: $checkedConvert(json, 'email', (v) => v as String),
      emailVerified: $checkedConvert(json, 'emailVerified', (v) => v as bool),
      profilePictureLink:
          $checkedConvert(json, 'profilePictureLink', (v) => v as String),
      profileBanner: $checkedConvert(json, 'profileBanner', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$AussieUserToJson(AussieUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'profilePictureLink': instance.profilePictureLink,
      'profileBanner': instance.profileBanner,
    };
