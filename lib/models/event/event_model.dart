import 'package:aussie/models/event_image/event_image_model.dart';
import 'package:aussie/models/image_picking_state/image_picking_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.g.dart';
part 'event_model.freezed.dart';

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
    @JsonKey(ignore: true) List<ImageWithAttributes>? imageData,
    @JsonKey(ignore: true) ImageWithAttributes? bannerData,
    required String eventId,
    required String uid,
  }) = _EventModelSubmition;
  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}
