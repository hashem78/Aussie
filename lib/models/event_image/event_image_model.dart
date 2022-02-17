import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_image_model.g.dart';
part 'event_image_model.freezed.dart';

@freezed
class EventImageModel with _$EventImageModel {
  const factory EventImageModel({
    required String imageLink,
    required int width,
    required int height,
  }) = _EventImageModel;
  factory EventImageModel.fromJson(Map<String, dynamic> json) =>
      _$EventImageModelFromJson(json);
}
