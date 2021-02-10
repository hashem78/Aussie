// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventImageModel _$EventImageModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('EventImageModel', json, () {
    final val = EventImageModel(
      imageLink: $checkedConvert(json, 'imageLink', (v) => v as String),
      width: $checkedConvert(json, 'width', (v) => v as int),
      height: $checkedConvert(json, 'height', (v) => v as int),
    );
    return val;
  });
}

Map<String, dynamic> _$EventImageModelToJson(EventImageModel instance) =>
    <String, dynamic>{
      'imageLink': instance.imageLink,
      'width': instance.width,
      'height': instance.height,
    };
