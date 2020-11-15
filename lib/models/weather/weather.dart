import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class WeatherModel extends Equatable {
  final String day;
  final String state;
  final String iconString;
  final String title;
  final String imageUrl;
  final double highTemp;
  final double lowTemp;
  final double pressure;
  final double humidity;
  final String description;
  final List<WeatherModel> fourDayModels;
  const WeatherModel({
    this.day,
    this.state,
    this.iconString,
    this.title,
    this.imageUrl,
    this.highTemp,
    this.lowTemp,
    this.pressure,
    this.humidity,
    this.description,
  })  : assert(title != null && iconString != null),
        fourDayModels = null;
  const WeatherModel.withFourDays({
    this.day,
    this.state,
    @required this.iconString,
    @required this.title,
    @required this.fourDayModels,
    this.imageUrl,
    this.highTemp,
    this.lowTemp,
    this.pressure,
    this.description,
    this.humidity,
  }) : assert(title != null && iconString != null);

  @override
  List<Object> get props {
    return [
      day,
      state,
      iconString,
      title,
      imageUrl,
      highTemp,
      lowTemp,
      fourDayModels,
      pressure,
      humidity,
      description,
    ];
  }

  WeatherModel copyWith({
    String day,
    String state,
    String description,
    String iconString,
    String title,
    String imageUrl,
    double highTemp,
    double lowTemp,
    double pressure,
    double humidity,
    List<WeatherModel> fourDayModels,
  }) {
    return WeatherModel(
      day: day ?? this.day,
      state: state ?? this.state,
      iconString: iconString ?? this.iconString,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      highTemp: highTemp ?? this.highTemp,
      lowTemp: lowTemp ?? this.lowTemp,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'state': state,
      'iconString': iconString,
      'title': title,
      'imageUrl': imageUrl,
      'highTemp': highTemp,
      'lowTemp': lowTemp,
      'pressure': pressure,
      'humidity': humidity,
      'description': description,
      'fourDayModels': fourDayModels?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory WeatherModel.fromMapWithFourDays(Map<String, dynamic> map) {
    if (map == null) return null;

    return WeatherModel.withFourDays(
      day: map['day'],
      state: map['state'],
      iconString: map['iconString'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      highTemp: map['highTemp'],
      lowTemp: map['lowTemp'],
      pressure: map['pressure'],
      humidity: map['humidity'],
      description: map['description'],
      fourDayModels: List<WeatherModel>.from(
          map['fourDayModels']?.map((x) => WeatherModel.fromMap(x))),
    );
  }
  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return WeatherModel(
      day: map['day'],
      state: map['state'],
      iconString: map['iconString'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      highTemp: map['highTemp'],
      lowTemp: map['lowTemp'],
      pressure: map['pressure'],
      humidity: map['humidity'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source));
  factory WeatherModel.fromJsonWithFourDays(String source) =>
      WeatherModel.fromMapWithFourDays(json.decode(source));

  @override
  bool get stringify => true;
}
