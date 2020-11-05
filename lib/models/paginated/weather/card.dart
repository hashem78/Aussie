import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class WeatherCardChildModel extends Equatable {
  final String icon;
  final int temp;
  final String state;
  final String title;
  const WeatherCardChildModel({
    this.icon,
    this.temp,
    this.state,
    this.title,
  });

  @override
  List<Object> get props => [icon, temp, state, title];
}
