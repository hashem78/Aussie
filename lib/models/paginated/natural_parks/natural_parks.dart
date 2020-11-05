import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:Aussie/interfaces/paginated_data_model.dart';

@immutable
class NaturalParkModel extends Equatable implements PaginatedDataModel {
  final String title;
  final String summary;
  final String imageUrl;
  final String longitude;
  final String latitude;
  final List<Map<String, String>> sections;

  const NaturalParkModel({
    this.title,
    this.summary,
    this.imageUrl,
    this.longitude,
    this.latitude,
    this.sections,
  });

  @override
  List<Object> get props => [title, summary, imageUrl, sections];
}
