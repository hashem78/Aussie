import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:aussie/interfaces/paginated_data_model.dart';

@immutable
class NaturalParkModel extends Equatable implements PaginatedDataModel {
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

  NaturalParkModel copyWith({
    String title,
    String summary,
    String imageUrl,
    String longitude,
    String latitude,
    List<Map<String, String>> sections,
  }) {
    return NaturalParkModel(
      parkName: title ?? this.parkName,
      summary: summary ?? this.summary,
      imageUrl: imageUrl ?? this.imageUrl,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      sections: sections ?? this.sections,
    );
  }

  factory NaturalParkModel.fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return NaturalParkModel(
      parkName: map['park_name'],
      summary: map['summary'],
      imageUrl: map['image_link'],
      longitude: map['longitude'],
      latitude: map['latitude'],
      sections: List<Map<String, dynamic>>.from(map['sections']?.map((x) => x)),
    );
  }

  @override
  bool get stringify => true;

  Map<String, dynamic> get toJson => {
        'park_name': parkName,
        'summary': summary,
        'imageLink': imageUrl,
        'longitude': longitude,
        'latitude': latitude,
        'sections': sections,
      };
}
