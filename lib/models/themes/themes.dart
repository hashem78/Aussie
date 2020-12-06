import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/presentation/screens/info/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/info/species/fauna.dart';
import 'package:aussie/presentation/screens/info/species/flora.dart';
import 'package:aussie/presentation/screens/info/teritories/teritories.dart';
import 'package:aussie/presentation/screens/info/weather/weather.dart';

@immutable
class ThemeModel extends Equatable {
  final Brightness brightness;

  final AussieColorData faunaScreenColor;
  final AussieColorData floraScreenColor;
  final AussieColorData teritoriesScreenColor;
  final AussieColorData weatherScreenColor;
  final AussieColorData naturalParksScreenColor;
  static final Map<String, dynamic> defaultThemeMap = {
    "brightness": "light",
  };
  ThemeModel({
    Brightness brightness,
    AussieColorData peopleScreenColor,
    AussieColorData foodScreenColor,
    AussieColorData eventsScreenColor,
    AussieColorData placesScreenColor,
    AussieColorData entertainmentScreenColor,
    AussieColorData faunaScreenColor,
    AussieColorData floraScreenColor,
    AussieColorData teritoriesScreenColor,
    AussieColorData weatherScreenColor,
    AussieColorData naturalParksScreenColor,
  })  : brightness = brightness ?? Brightness.light,
        faunaScreenColor = faunaScreenColor ?? FaunaScreen.data.light,
        floraScreenColor = floraScreenColor ?? FloraScreen.data.light,
        teritoriesScreenColor =
            teritoriesScreenColor ?? TeritoriesScreen.data.light,
        weatherScreenColor = weatherScreenColor ?? WeatherScreen.data.light,
        naturalParksScreenColor =
            naturalParksScreenColor ?? NaturalParksScreen.data.light;

  factory ThemeModel.fromMap(Map<String, dynamic> map) {
    return ThemeModel(
      brightness:
          map['brightness'] == "light" ? Brightness.light : Brightness.dark,
      faunaScreenColor:
          AussieColorData.fromMap(map[FaunaScreen.data.themeAttribute]),
      floraScreenColor:
          AussieColorData.fromMap(map[FloraScreen.data.themeAttribute]),
      teritoriesScreenColor:
          AussieColorData.fromMap(map[TeritoriesScreen.data.themeAttribute]),
      weatherScreenColor:
          AussieColorData.fromMap(map[WeatherScreen.data.themeAttribute]),
      naturalParksScreenColor:
          AussieColorData.fromMap(map[NaturalParksScreen.data.themeAttribute]),
    );
  }
  Map<String, dynamic> get toMap => {
        "brightness": brightness == Brightness.light ? "light" : "dark",
        FaunaScreen.data.themeAttribute: faunaScreenColor.toMap(),
        FloraScreen.data.themeAttribute: floraScreenColor.toMap(),
        TeritoriesScreen.data.themeAttribute: teritoriesScreenColor.toMap(),
        WeatherScreen.data.themeAttribute: weatherScreenColor.toMap(),
        NaturalParksScreen.data.themeAttribute: naturalParksScreenColor.toMap(),
      };
  String toJson() => jsonEncode(toMap);

  @override
  List<Object> get props {
    return [
      brightness,
      faunaScreenColor,
      floraScreenColor,
      teritoriesScreenColor,
      weatherScreenColor,
      naturalParksScreenColor,
    ];
  }

  ThemeModel copyWith({
    Brightness brightness,
    AussieColorData faunaScreenColor,
    AussieColorData floraScreenColor,
    AussieColorData teritoriesScreenColor,
    AussieColorData weatherScreenColor,
    AussieColorData naturalParksScreenColor,
    AussieColorData dykScreenColor,
  }) {
    return ThemeModel(
      brightness: brightness ?? this.brightness,
      faunaScreenColor: faunaScreenColor ?? this.faunaScreenColor,
      floraScreenColor: floraScreenColor ?? this.floraScreenColor,
      teritoriesScreenColor:
          teritoriesScreenColor ?? this.teritoriesScreenColor,
      weatherScreenColor: weatherScreenColor ?? this.weatherScreenColor,
      naturalParksScreenColor:
          naturalParksScreenColor ?? this.naturalParksScreenColor,
    );
  }

  @override
  bool get stringify => true;
}
