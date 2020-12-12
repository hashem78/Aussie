// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigninModel _$SigninModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('SigninModel', json, () {
    final val = SigninModel(
      $checkedConvert(json, 'email', (v) => v as String),
      $checkedConvert(json, 'password', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$SigninModelToJson(SigninModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
