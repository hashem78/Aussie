import 'package:aussie/interfaces/paginated_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'natural_parks_model.g.dart';

@JsonSerializable(
  createFactory: true,
  checked: true,
  createToJson: false,
)
@immutable
class NaturalParkModel extends Equatable implements IPaginatedData {
  // ignore: non_constant_identifier_names
  final String? park_name;
  final String? summary;
  // ignore: non_constant_identifier_names
  final String? image_link;
  final String? longitude;
  final String? latitude;
  final List<Map<String, String>>? sections;

  const NaturalParkModel({
    // ignore: non_constant_identifier_names
    this.park_name,
    this.summary,
    // ignore: non_constant_identifier_names
    this.image_link,
    this.longitude,
    this.latitude,
    this.sections,
  });

  @override
  List<Object?> get props {
    return <Object?>[
      park_name,
      summary,
      image_link,
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
