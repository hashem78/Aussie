// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teritory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeritoryModel _$TeritoryModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('TeritoryModel', json, () {
    final val = TeritoryModel(
      city: $checkedConvert(json, 'city', (v) => v as String?),
      lat: $checkedConvert(json, 'lat', (v) => v as String?),
      lng: $checkedConvert(json, 'lng', (v) => v as String?),
      admin: $checkedConvert(json, 'admin', (v) => v as String?),
      population: $checkedConvert(json, 'population', (v) => v as String?),
    );
    return val;
  });
}
