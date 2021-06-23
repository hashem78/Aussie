import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class AussieGMapModel extends Equatable {
  final String? longitude;
  final String? latitude;
  final String? title;

  const AussieGMapModel({
    required this.longitude,
    required this.latitude,
    required this.title,
  }) : assert(
          longitude != null && latitude != null && title != null,
          "A maps model has a null value in it",
        );

  @override
  List<Object?> get props => [longitude, latitude];
  @override
  bool get stringify => true;
}
