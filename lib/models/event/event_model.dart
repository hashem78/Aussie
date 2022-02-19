import 'dart:typed_data';

import 'package:aussie/models/event_image/event_image_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.g.dart';
part 'event_model.freezed.dart';

class AussieByteData {
  final ByteData? byteData;
  final int? width;
  final int? height;

  AussieByteData({
    this.byteData,
    this.width,
    this.height,
  });
}

@freezed
class EventModel with _$EventModel {
  const factory EventModel.remote({
    required String title,
    required String subtitle,
    required int startingTimeStamp,
    required int endingTimeStamp,
    required double lat,
    required double lng,
    required String description,
    required String address,
    required List<EventImageModel> galleryImages,
    required EventImageModel bannerImage,
    required String eventId,
    required String uid,
  }) = _EventModel;
  const factory EventModel.submition({
    required String title,
    required String subtitle,
    required int startingTimeStamp,
    required int endingTimeStamp,
    required double lat,
    required double lng,
    required String description,
    required String address,
    @JsonKey(ignore: true) List<AussieByteData>? imageData,
    @JsonKey(ignore: true) AussieByteData? bannerData,
    required String eventId,
    required String uid,
  }) = _EventModelSubmition;
  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}
