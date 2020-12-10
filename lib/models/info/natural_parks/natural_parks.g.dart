// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'natural_parks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NaturalParkModel _$NaturalParkModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('NaturalParkModel', json, () {
    final val = NaturalParkModel(
      parkName: $checkedConvert(json, 'parkName', (v) => v as String),
      summary: $checkedConvert(json, 'summary', (v) => v as String),
      imageUrl: $checkedConvert(json, 'imageUrl', (v) => v as String),
      longitude: $checkedConvert(json, 'longitude', (v) => v as String),
      latitude: $checkedConvert(json, 'latitude', (v) => v as String),
      sections: $checkedConvert(json, 'sections',
          (v) => (v as List)?.map((e) => e as Map<String, dynamic>)?.toList()),
    );
    return val;
  });
}
