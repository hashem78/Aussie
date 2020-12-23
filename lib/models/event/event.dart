import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

// Every event model is going to have a collection containing attendees and a collection containing post uids
@JsonSerializable(
  checked: true,
  createToJson: true,
  createFactory: true,
)
@immutable
class EventModel extends Equatable {
  const EventModel({
    this.eventId,
    this.uid,
    this.bannerImageLink,
    this.title,
    this.subtitle,
    this.startingTimeStamp,
    this.endingTimeStamp,
    this.lat,
    this.lng,
    this.description,
    this.galleryImageLinks,
    this.address,
  });
  final String eventId;
  final String uid;
  @JsonKey(defaultValue: "")
  final String bannerImageLink;
  @JsonKey(defaultValue: "")
  final String title;
  @JsonKey(defaultValue: "")
  final String subtitle;
  @JsonKey(defaultValue: 0)
  final int startingTimeStamp;
  @JsonKey(defaultValue: 0)
  final int endingTimeStamp;
  @JsonKey(defaultValue: 0)
  final double lat;
  @JsonKey(defaultValue: 0)
  final double lng;
  @JsonKey(defaultValue: "")
  final String description;
  @JsonKey(defaultValue: "")
  final String address;
  @JsonKey(defaultValue: [])
  final List<String> galleryImageLinks;
  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventModelToJson(this);

  @override
  List<Object> get props {
    return [
      eventId,
      uid,
      bannerImageLink,
      title,
      subtitle,
      startingTimeStamp,
      endingTimeStamp,
      lat,
      lng,
      description,
      galleryImageLinks,
      address,
    ];
  }
}
