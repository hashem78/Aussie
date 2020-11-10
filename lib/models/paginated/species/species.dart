import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:Aussie/interfaces/paginated_data_model.dart';

@immutable
class SpeciesDetailsModel extends Equatable implements PaginatedDataModel {
  final String commonName;
  final String scientificName;
  final String type;
  final String conservationStatus;
  final String description;
  final String titleImageUrl;
  const SpeciesDetailsModel({
    @required this.commonName,
    @required this.scientificName,
    @required this.type,
    this.conservationStatus,
    @required this.description,
    @required this.titleImageUrl,
  }) : assert(
          commonName != null &&
              scientificName != null &&
              type != null &&
              titleImageUrl != null,
          description != null,
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
    );
  }

  factory SpeciesDetailsModel.fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    return SpeciesDetailsModel(
      commonName: map['commonName'],
      scientificName: map['scientificName'],
      type: map['type'],
      conservationStatus: map['conservationStatus'],
      description: map['description'],
      titleImageUrl: map['titleImageUrl'],
    );
  }

  @override
  bool get stringify => true;

  @override
  Map<String, dynamic> get toJson => {
        'commonName': commonName,
        'scientificName': scientificName,
        'type': type,
        'conservationStatus': conservationStatus,
        'description': description,
        'titleImageUrl': titleImageUrl,
      };
}
