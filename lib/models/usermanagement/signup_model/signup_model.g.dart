// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupModel _$SignupModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('SignupModel', json, () {
    final val = SignupModel(
      email: $checkedConvert(json, 'email', (v) => v as String?),
      password: $checkedConvert(json, 'password', (v) => v as String?),
      profileImagePath:
          $checkedConvert(json, 'profileImagePath', (v) => v as String?),
      username: $checkedConvert(json, 'username', (v) => v as String?),
      fullname: $checkedConvert(json, 'fullname', (v) => v as String?),
    );
    return val;
  });
}

Map<String, dynamic> _$SignupModelToJson(SignupModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'profileImagePath': instance.profileImagePath,
      'username': instance.username,
      'fullname': instance.fullname,
    };
