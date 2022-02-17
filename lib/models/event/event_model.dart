import 'package:aussie/models/event_image/event_image_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.g.dart';
part 'event_model.freezed.dart';

@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    required String title,
    required String subtitle,
    required int startingTimeStamp,
    required int endingTimeStamp,
    required double lat,
    required double lng,
    required String description,
    required String address,
    required List<EventImageModel> galleryImages,
    required String eventId,
    required String uid,
    required EventImageModel bannerImage,
  }) = _EventModel;
  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}
