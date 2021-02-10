// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'natural_parks_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NaturalParkModel _$NaturalParkModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('NaturalParkModel', json, () {
    final val = NaturalParkModel(
      park_name: $checkedConvert(json, 'park_name', (v) => v as String),
      summary: $checkedConvert(json, 'summary', (v) => v as String),
      image_link: $checkedConvert(json, 'image_link', (v) => v as String),
      longitude: $checkedConvert(json, 'longitude', (v) => v as String),
      latitude: $checkedConvert(json, 'latitude', (v) => v as String),
      sections: $checkedConvert(
          json,
          'sections',
          (v) => (v as List)
              ?.map((e) => (e as Map<String, dynamic>)?.map(
                    (k, e) => MapEntry(k, e as String),
                  ))
              ?.toList()),
    );
    return val;
  });
}
