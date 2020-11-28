import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/presentation/screens/dyk.dart';
import 'package:aussie/presentation/screens/info/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/info/species/fauna.dart';
import 'package:aussie/presentation/screens/info/species/flora.dart';
import 'package:aussie/presentation/screens/info/teritories/teritories.dart';
import 'package:aussie/presentation/screens/info/weather/weather.dart';
import 'package:aussie/presentation/screens/main/entertainment.dart';
import 'package:aussie/presentation/screens/main/events.dart';
import 'package:aussie/presentation/screens/main/food_drinks.dart';
import 'package:aussie/presentation/screens/main/people.dart';
import 'package:aussie/presentation/screens/main/places.dart';

@immutable
class ThemeModel extends Equatable {
  final Brightness brightness;
  final AussieColorData peopleScreenColor;
  final AussieColorData foodScreenColor;
  final AussieColorData eventsScreenColor;
  final AussieColorData placesScreenColor;
  final AussieColorData entertainmentScreenColor;
  final AussieColorData faunaScreenColor;
  final AussieColorData floraScreenColor;
  final AussieColorData teritoriesScreenColor;
  final AussieColorData weatherScreenColor;
  final AussieColorData naturalParksScreenColor;
  final AussieColorData dykScreenColor;
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
    AussieColorData dykScreenColor,
  })  : brightness = brightness ?? Brightness.light,
        peopleScreenColor = peopleScreenColor ?? PeopleScreen.data.light,
        foodScreenColor = foodScreenColor ?? FoodScreen.data.light,
        eventsScreenColor = eventsScreenColor ?? EventsScreen.data.light,
        placesScreenColor = placesScreenColor ?? PlacesScreen.data.light,
        entertainmentScreenColor =
            entertainmentScreenColor ?? EntertainmentScreen.data.light,
        faunaScreenColor = faunaScreenColor ?? FaunaScreen.data.light,
        floraScreenColor = floraScreenColor ?? FloraScreen.data.light,
        teritoriesScreenColor =
            teritoriesScreenColor ?? TeritoriesScreen.data.light,
        weatherScreenColor = weatherScreenColor ?? WeatherScreen.data.light,
        naturalParksScreenColor =
            naturalParksScreenColor ?? NaturalParksScreen.data.light,
        dykScreenColor = dykScreenColor ?? DYKScreen.data.light;

  factory ThemeModel.fromMap(Map<String, dynamic> map) {
    return ThemeModel(
      brightness:
          map['brightness'] == "light" ? Brightness.light : Brightness.dark,
      peopleScreenColor:
          AussieColorData.fromMap(map[PeopleScreen.data.themeAttribute]),
      foodScreenColor:
          AussieColorData.fromMap(map[FoodScreen.data.themeAttribute]),
      eventsScreenColor:
          AussieColorData.fromMap(map[EventsScreen.data.themeAttribute]),
      placesScreenColor:
          AussieColorData.fromMap(map[PlacesScreen.data.themeAttribute]),
      entertainmentScreenColor:
          AussieColorData.fromMap(map[EntertainmentScreen.data.themeAttribute]),
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
      dykScreenColor:
          AussieColorData.fromMap(map[DYKScreen.data.themeAttribute]),
    );
  }
  Map<String, dynamic> get toMap => {
        "brightness": brightness == Brightness.light ? "light" : "dark",
        PeopleScreen.data.themeAttribute: peopleScreenColor.toMap(),
        FoodScreen.data.themeAttribute: foodScreenColor.toMap(),
        EventsScreen.data.themeAttribute: eventsScreenColor.toMap(),
        PlacesScreen.data.themeAttribute: placesScreenColor.toMap(),
        EntertainmentScreen.data.themeAttribute:
            entertainmentScreenColor.toMap(),
        FaunaScreen.data.themeAttribute: faunaScreenColor.toMap(),
        FloraScreen.data.themeAttribute: floraScreenColor.toMap(),
        TeritoriesScreen.data.themeAttribute: teritoriesScreenColor.toMap(),
        WeatherScreen.data.themeAttribute: weatherScreenColor.toMap(),
        NaturalParksScreen.data.themeAttribute: naturalParksScreenColor.toMap(),
        DYKScreen.data.themeAttribute: dykScreenColor.toMap(),
      };
  String toJson() => jsonEncode(toMap);

  @override
  List<Object> get props {
    return [
      brightness,
      peopleScreenColor,
      foodScreenColor,
      eventsScreenColor,
      placesScreenColor,
      entertainmentScreenColor,
      faunaScreenColor,
      floraScreenColor,
      teritoriesScreenColor,
      weatherScreenColor,
      naturalParksScreenColor,
      dykScreenColor,
    ];
  }

  ThemeModel copyWith({
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
    AussieColorData dykScreenColor,
  }) {
    return ThemeModel(
      brightness: brightness ?? this.brightness,
      peopleScreenColor: peopleScreenColor ?? this.peopleScreenColor,
      foodScreenColor: foodScreenColor ?? this.foodScreenColor,
      eventsScreenColor: eventsScreenColor ?? this.eventsScreenColor,
      placesScreenColor: placesScreenColor ?? this.placesScreenColor,
      entertainmentScreenColor:
          entertainmentScreenColor ?? this.entertainmentScreenColor,
      faunaScreenColor: faunaScreenColor ?? this.faunaScreenColor,
      floraScreenColor: floraScreenColor ?? this.floraScreenColor,
      teritoriesScreenColor:
          teritoriesScreenColor ?? this.teritoriesScreenColor,
      weatherScreenColor: weatherScreenColor ?? this.weatherScreenColor,
      naturalParksScreenColor:
          naturalParksScreenColor ?? this.naturalParksScreenColor,
      dykScreenColor: dykScreenColor ?? this.dykScreenColor,
    );
  }

  @override
  bool get stringify => true;
}
