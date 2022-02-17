import 'package:freezed_annotation/freezed_annotation.dart';
part 'gmap.g.dart';
part 'gmap.freezed.dart';

@freezed
class AussieGMapModel with _$AussieGMapModel {
  const factory AussieGMapModel({
    required String? longitude,
    required String? latitude,
    required String? title,
  }) = _AussieGMapModel;
  factory AussieGMapModel.fromJson(Map<String, dynamic> json) =>
      _$AussieGMapModelFromJson(json);
}
