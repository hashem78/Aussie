import 'package:Aussie/interfaces/paginated_data_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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
    @required this.titleImageUrl,
    @required this.description,
  }) : assert(
          commonName != null &&
              scientificName != null &&
              type != null &&
              titleImageUrl != null,
          description != null,
        );

  @override
  List<Object> get props => [
        commonName,
        scientificName,
        type,
        conservationStatus,
        description,
      ];
}
