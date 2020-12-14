// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('EventModel', json, () {
    final val = EventModel(
      eventId: $checkedConvert(json, 'eventId', (v) => v as String) ?? '',
      uid: $checkedConvert(json, 'uid', (v) => v as String) ?? '',
      bannerImageLink:
          $checkedConvert(json, 'bannerImageLink', (v) => v as String) ?? '',
      title: $checkedConvert(json, 'title', (v) => v as String) ?? '',
      subitle: $checkedConvert(json, 'subitle', (v) => v as String) ?? '',
      startTimestamp:
          $checkedConvert(json, 'startTimestamp', (v) => v as int) ?? 0,
      endTimestamp: $checkedConvert(json, 'endTimestamp', (v) => v as int) ?? 0,
      lat: $checkedConvert(json, 'lat', (v) => v as int) ?? 0,
      lng: $checkedConvert(json, 'lng', (v) => v as int) ?? 0,
      description:
          $checkedConvert(json, 'description', (v) => v as String) ?? '',
      galleryImageLinks: $checkedConvert(json, 'galleryImageLinks',
              (v) => (v as List)?.map((e) => e as String)?.toList()) ??
          [],
    );
    return val;
  });
}

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'uid': instance.uid,
      'bannerImageLink': instance.bannerImageLink,
      'title': instance.title,
      'subitle': instance.subitle,
      'startTimestamp': instance.startTimestamp,
      'endTimestamp': instance.endTimestamp,
      'lat': instance.lat,
      'lng': instance.lng,
      'description': instance.description,
      'galleryImageLinks': instance.galleryImageLinks,
    };
