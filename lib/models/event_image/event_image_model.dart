import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_image_model.g.dart';

@JsonSerializable(
  checked: true,
  createToJson: true,
  createFactory: true,
  explicitToJson: true,
)
class EventImageModel extends Equatable {
  final String? imageLink;
  final int? width;
  final int? height;

  const EventImageModel({
    this.imageLink,
    this.width,
    this.height,
  });

  factory EventImageModel.fromJson(Map<String, dynamic> map) =>
      _$EventImageModelFromJson(map);
  Map<String, dynamic> toJson() => _$EventImageModelToJson(this);

  @override
  List<Object?> get props => <Object?>[
        imageLink,
        width,
        height,
      ];
}
