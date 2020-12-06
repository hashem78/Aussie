import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:aussie/interfaces/paginated_data.dart';

@immutable
class TeritoryModel extends Equatable implements IPaginatedData {
  final String title;
  final String latitude;
  final String longitude;
  final String population;

  final String admin;
  const TeritoryModel({
    this.title,
    this.latitude,
    this.longitude,
    this.admin,
    this.population,
  })  : assert(title != null, "title is null"),
        assert(latitude != null, "lat is null"),
        assert(longitude != null, "lan is null"),
        assert(admin != null, "admin is null"),
        assert(population != null, "population is null");

  @override
  List<Object> get props => [title, latitude, longitude, admin];

  TeritoryModel copyWith({
    String title,
    String latitude,
    String longitude,
    String admin,
    String population,
  }) {
    return TeritoryModel(
      title: title ?? this.title,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      admin: admin ?? this.admin,
      population: population ?? this.population,
    );
  }

  Map<String, dynamic> get toJson {
    return {
      'city': title,
      'lat': latitude,
      'lng': longitude,
      'admin': admin,
      'population': population,
    };
  }

  factory TeritoryModel.fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    return TeritoryModel(
      title: map['city'],
      latitude: map['lat'],
      longitude: map['lng'],
      admin: map['admin'],
      population: map['population'],
    );
  }

  @override
  bool get stringify => true;
}
