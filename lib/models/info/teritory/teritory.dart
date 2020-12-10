import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:aussie/interfaces/paginated_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'teritory.g.dart';

@JsonSerializable(
  createFactory: true,
  checked: true,
  createToJson: false,
)
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
  });

  @override
  List<Object> get props => [title, latitude, longitude, admin];
  factory TeritoryModel.fromJson(Map<String, dynamic> json) =>
      _$TeritoryModelFromJson(json);

  @override
  bool get stringify => true;
}
