// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('EventModel', json, () {
    final val = EventModel(
      eventId: $checkedConvert(json, 'eventId', (v) => v as String?),
      uid: $checkedConvert(json, 'uid', (v) => v as String?),
      bannerImage: $checkedConvert(
          json,
          'bannerImage',
          (v) => v == null
              ? null
              : EventImageModel.fromJson(v as Map<String, dynamic>)),
      title: $checkedConvert(json, 'title', (v) => v as String?) ?? '',
      subtitle: $checkedConvert(json, 'subtitle', (v) => v as String?) ?? '',
      startingTimeStamp:
          $checkedConvert(json, 'startingTimeStamp', (v) => v as int?) ?? 0,
      endingTimeStamp:
          $checkedConvert(json, 'endingTimeStamp', (v) => v as int?) ?? 0,
      lat: $checkedConvert(json, 'lat', (v) => (v as num?)?.toDouble()) ?? 0,
      lng: $checkedConvert(json, 'lng', (v) => (v as num?)?.toDouble()) ?? 0,
      description:
          $checkedConvert(json, 'description', (v) => v as String?) ?? '',
      galleryImages: $checkedConvert(
              json,
              'galleryImages',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      EventImageModel.fromJson(e as Map<String, dynamic>))
                  .toList()) ??
          [],
      address: $checkedConvert(json, 'address', (v) => v as String?) ?? '',
    );
    return val;
  });
}

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'uid': instance.uid,
      'bannerImage': instance.bannerImage?.toJson(),
      'title': instance.title,
      'subtitle': instance.subtitle,
      'startingTimeStamp': instance.startingTimeStamp,
      'endingTimeStamp': instance.endingTimeStamp,
      'lat': instance.lat,
      'lng': instance.lng,
      'description': instance.description,
      'address': instance.address,
      'galleryImages': instance.galleryImages?.map((e) => e.toJson()).toList(),
    };
