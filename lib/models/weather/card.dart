import 'package:aussie/models/weather/weather.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class WeatherCardChildModel extends Equatable {
  final WeatherModel model;
  final String title;

  const WeatherCardChildModel({
    @required this.model,
    this.title,
  });

  @override
  List<Object> get props => [model, title];
}
