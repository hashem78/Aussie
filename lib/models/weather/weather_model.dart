import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class WeatherModel extends Equatable {
  final String? day;
  final String? state;
  final String? iconString;
  final String? title;
  final String? imageUrl;
  final double? highTemp;
  final double? lowTemp;
  final double? pressure;
  final double? humidity;
  final String? description;
  final List<WeatherModel>? fourDayModels;
  const WeatherModel({
    this.day,
    this.state,
    required this.iconString,
    required this.title,
    this.imageUrl,
    this.highTemp,
    this.lowTemp,
    this.pressure,
    this.humidity,
    this.description,
  }) : fourDayModels = null;
  const WeatherModel.withFourDays({
    this.day,
    this.state,
    required this.iconString,
    required this.title,
    required this.fourDayModels,
    this.imageUrl,
    this.highTemp,
    this.lowTemp,
    this.pressure,
    this.description,
    this.humidity,
  });

  @override
  List<Object?> get props {
    return <Object?>[
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
    String? day,
    String? state,
    String? description,
    String? iconString,
    String? title,
    String? imageUrl,
    double? highTemp,
    double? lowTemp,
    double? pressure,
    double? humidity,
    List<WeatherModel>? fourDayModels,
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
    return <String, dynamic>{
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
      'fourDayModels':
          fourDayModels!.map((WeatherModel x) => x.toMap()).toList(),
    };
  }

  factory WeatherModel.fromMapWithFourDays(Map<String, dynamic>? map) {
    final List<WeatherModel> weatherModels = <WeatherModel>[];
    if (map?['fourDayModels'] != null) {
      final List<dynamic> fourDays = map!['fourDayModels'] as List<dynamic>;

      for (final Map<String, dynamic> model in fourDays) {
        weatherModels.add(WeatherModel.fromMap(model));
      }
    }

    return WeatherModel.withFourDays(
      day: map?['day'] as String?,
      state: map?['state'] as String?,
      iconString: map?['iconString'] as String?,
      title: map?['title'] as String?,
      imageUrl: map?['imageUrl'] as String?,
      highTemp: map?['highTemp'] as double?,
      lowTemp: map?['lowTemp'] as double?,
      pressure: map?['pressure'] as double?,
      humidity: map?['humidity'] as double?,
      description: map?['description'] as String?,
      fourDayModels: weatherModels,
    );
  }
  factory WeatherModel.fromMap(Map<String, dynamic>? map) {
    return WeatherModel(
      day: map?['day'] as String?,
      state: map?['state'] as String?,
      iconString: map?['iconString'] as String?,
      title: map?['title'] as String?,
      imageUrl: map?['imageUrl'] as String?,
      highTemp: map?['highTemp'] as double?,
      lowTemp: map?['lowTemp'] as double?,
      pressure: map?['pressure'] as double?,
      humidity: map?['humidity'] as double?,
      description: map?['description'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) => WeatherModel.fromMap(
        json.decode(source) as Map<String, dynamic>?,
      );
  factory WeatherModel.fromJsonWithFourDays(String source) =>
      WeatherModel.fromMapWithFourDays(
        json.decode(source) as Map<String, dynamic>?,
      );

  @override
  bool get stringify => true;
}
