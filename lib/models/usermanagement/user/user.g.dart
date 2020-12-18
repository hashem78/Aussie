// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AussieUser _$AussieUserFromJson(Map<String, dynamic> json) {
  return $checkedNew('AussieUser', json, () {
    final val = AussieUser(
      uid: $checkedConvert(json, 'uid', (v) => v as String),
      attends: $checkedConvert(json, 'attends',
              (v) => (v as List)?.map((e) => e as String)?.toList()) ??
          [],
      displayName: $checkedConvert(json, 'displayName', (v) => v as String),
      email: $checkedConvert(json, 'email', (v) => v as String),
      emailVerified: $checkedConvert(json, 'emailVerified', (v) => v as bool),
      username: $checkedConvert(json, 'username', (v) => v as String),
      numberOfFollowers:
          $checkedConvert(json, 'numberOfFollowers', (v) => v as int) ?? 0,
      numberOfFollowing:
          $checkedConvert(json, 'numberOfFollowing', (v) => v as int) ?? 0,
      numberOfPosts:
          $checkedConvert(json, 'numberOfPosts', (v) => v as int) ?? 0,
      profilePictureLink:
          $checkedConvert(json, 'profilePictureLink', (v) => v as String) ?? '',
      profileBannerLink:
          $checkedConvert(json, 'profileBannerLink', (v) => v as String) ?? '',
      fullname: $checkedConvert(json, 'fullname', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$AussieUserToJson(AussieUser instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'username': instance.username,
      'fullname': instance.fullname,
      'uid': instance.uid,
      'attends': instance.attends,
      'numberOfFollowers': instance.numberOfFollowers,
      'numberOfFollowing': instance.numberOfFollowing,
      'numberOfPosts': instance.numberOfPosts,
      'profilePictureLink': instance.profilePictureLink,
      'profileBannerLink': instance.profileBannerLink,
    };
