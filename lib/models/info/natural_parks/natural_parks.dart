import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:aussie/interfaces/paginated_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'natural_parks.g.dart';

@JsonSerializable(
  createFactory: true,
  checked: true,
  createToJson: false,
)
@immutable
class NaturalParkModel extends Equatable implements IPaginatedData {
  final String parkName;
  final String summary;
  final String imageUrl;
  final String longitude;
  final String latitude;
  final List<Map<String, dynamic>> sections;

  const NaturalParkModel({
    this.parkName,
    this.summary,
    this.imageUrl,
    this.longitude,
    this.latitude,
    this.sections,
  });

  @override
  List<Object> get props {
    return [
      parkName,
      summary,
      imageUrl,
      longitude,
      latitude,
      sections,
    ];
  }

  factory NaturalParkModel.fromJson(Map<String, dynamic> json) =>
      _$NaturalParkModelFromJson(json);

  @override
  bool get stringify => true;
}
