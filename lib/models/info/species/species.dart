import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:aussie/interfaces/paginated_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'species.g.dart';

@JsonSerializable(
  createFactory: true,
  checked: true,
  createToJson: false,
)
@immutable
class SpeciesDetailsModel extends Equatable implements IPaginatedData {
  final String commonName;
  final String scientificName;
  final String type;
  final String conservationStatus;
  final String description;
  final String titleImageUrl;
  final List<String> thumbnailImageUrls;
  const SpeciesDetailsModel({
    @required String commonName,
    @required this.scientificName,
    this.type,
    this.conservationStatus,
    @required this.description,
    this.titleImageUrl,
    this.thumbnailImageUrls,
  })  : commonName = commonName == "" ? scientificName : commonName,
        assert(
          commonName != null && scientificName != null && description != null,
        );

  @override
  List<Object> get props {
    return [
      commonName,
      scientificName,
      type,
      conservationStatus,
      description,
      titleImageUrl,
      thumbnailImageUrls,
    ];
  }

  factory SpeciesDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$SpeciesDetailsModelFromJson(json);

  @override
  bool get stringify => true;
}
