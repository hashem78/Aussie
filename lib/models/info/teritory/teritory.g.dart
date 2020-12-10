// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teritory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeritoryModel _$TeritoryModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('TeritoryModel', json, () {
    final val = TeritoryModel(
      title: $checkedConvert(json, 'title', (v) => v as String),
      latitude: $checkedConvert(json, 'latitude', (v) => v as String),
      longitude: $checkedConvert(json, 'longitude', (v) => v as String),
      admin: $checkedConvert(json, 'admin', (v) => v as String),
      population: $checkedConvert(json, 'population', (v) => v as String),
    );
    return val;
  });
}
