import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:aussie/interfaces/paginated_data.dart';

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

  SpeciesDetailsModel copyWith({
    String commonName,
    String scientificName,
    String type,
    String conservationStatus,
    String description,
    String titleImageUrl,
  }) {
    return SpeciesDetailsModel(
      commonName: commonName ?? this.commonName,
      scientificName: scientificName ?? this.scientificName,
      type: type ?? this.type,
      conservationStatus: conservationStatus ?? this.conservationStatus,
      description: description ?? this.description,
      titleImageUrl: titleImageUrl ?? this.titleImageUrl,
      thumbnailImageUrls: thumbnailImageUrls ?? this.thumbnailImageUrls,
    );
  }

  factory SpeciesDetailsModel.fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    List<String> images;
    if (map.containsKey("imageUrls")) {
      images = List.from(map["imageUrls"]);
    }
    return SpeciesDetailsModel(
      commonName: map['commonName'],
      scientificName: map['scientificName'],
      type: map['type'],
      conservationStatus: map['conservationStatus'],
      description: map['description'],
      titleImageUrl: map['titleImageUrl'],
      thumbnailImageUrls: images,
    );
  }

  @override
  bool get stringify => true;
}
