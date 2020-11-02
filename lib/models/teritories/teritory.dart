import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class TeritoryModel extends Equatable {
  final String title;
  final double latitude;
  final double longitude;

  final String admin;
  const TeritoryModel({
    this.title,
    this.longitude,
    this.latitude,
    this.admin,
  });

  @override
  List<Object> get props => [title, longitude, latitude, admin];
}
