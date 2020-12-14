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
  @JsonKey(defaultValue: "")
  final String eventId;
  @JsonKey(defaultValue: "")
  final String uid;
  @JsonKey(defaultValue: "")
  final String bannerImageLink;
  @JsonKey(defaultValue: "")
  final String title;
  @JsonKey(defaultValue: "")
  final String subitle;
  @JsonKey(defaultValue: 0)
  final int startTimestamp;
  @JsonKey(defaultValue: 0)
  final int endTimestamp;
  @JsonKey(defaultValue: 0)
  final int lat;
  @JsonKey(defaultValue: 0)
  final int lng;
  @JsonKey(defaultValue: "")
  final String description;
  @JsonKey(defaultValue: const [])
  final List<String> galleryImageLinks;
  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventModelToJson(this);

  EventModel({
    this.eventId,
    this.uid,
    this.bannerImageLink,
    this.title,
    this.subitle,
    this.startTimestamp,
    this.endTimestamp,
    this.lat,
    this.lng,
    this.description,
    this.galleryImageLinks,
  });

  @override
  List<Object> get props {
    return [
      eventId,
      uid,
      bannerImageLink,
      title,
      subitle,
      startTimestamp,
      endTimestamp,
      lat,
      lng,
      description,
      galleryImageLinks,
    ];
  }
}
