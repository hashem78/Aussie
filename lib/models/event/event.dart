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
  final int timestamp;
  @JsonKey(defaultValue: "")
  final String description;
  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventModelToJson(this);

  EventModel({
    this.eventId,
    this.uid,
    this.bannerImageLink,
    this.title,
    this.subitle,
    this.timestamp,
    this.description,
  });

  @override
  List<Object> get props => [
        eventId,
        uid,
        bannerImageLink,
        title,
        subitle,
        timestamp,
        description,
      ];
}
