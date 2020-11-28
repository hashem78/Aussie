import 'dart:convert';

import 'package:aussie/presentation/screens/main/entertainment.dart';
import 'package:aussie/presentation/screens/main/events.dart';
import 'package:aussie/presentation/screens/main/food_drinks.dart';
import 'package:aussie/presentation/screens/main/people.dart';
import 'package:aussie/presentation/screens/main/places.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MainScreenColorData extends Equatable {
  final Color swatchColor;
  final Color backgroundColor;
  const MainScreenColorData({
    @required this.swatchColor,
    @required this.backgroundColor,
  }) : assert(swatchColor != null && backgroundColor != null);
  @override
  List<Object> get props => [swatchColor, backgroundColor];

  Map<String, dynamic> toMap() {
    return {
      'swatchColor': swatchColor.value,
      'backgroundColor': backgroundColor.value,
    };
  }

  factory MainScreenColorData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MainScreenColorData(
      swatchColor: Color(map['swatchColor']),
      backgroundColor: Color(map['backgroundColor']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MainScreenColorData.fromJson(String source) =>
      MainScreenColorData.fromMap(json.decode(source));

  MainScreenColorData copyWith({
    Color swatchColor,
    Color backgroundColor,
  }) {
    return MainScreenColorData(
      swatchColor: swatchColor ?? this.swatchColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  bool get stringify => true;
}

@immutable
class ThemeModel extends Equatable {
  final Brightness brightness;
  final MainScreenColorData peopleScreenColor;
  final MainScreenColorData foodScreenColor;
  final MainScreenColorData eventsScreenColor;
  final MainScreenColorData placesScreenColor;
  final MainScreenColorData entertainmentScreenColor;
  static final Map<String, dynamic> defaultThemeMap = {
    "brightness": "light",
  };
  ThemeModel({
    Brightness brightness,
    MainScreenColorData peopleScreenColor,
    MainScreenColorData foodScreenColor,
    MainScreenColorData eventsScreenColor,
    MainScreenColorData placesScreenColor,
    MainScreenColorData entertainmentScreenColor,
  })  : brightness = brightness ?? Brightness.light,
        peopleScreenColor = peopleScreenColor ??
            MainScreenColorData(
              swatchColor: Colors.amber,
              backgroundColor: Colors.amber.shade400,
            ),
        foodScreenColor = foodScreenColor ??
            MainScreenColorData(
              swatchColor: Colors.amber,
              backgroundColor: Colors.amber.shade400,
            ),
        eventsScreenColor = eventsScreenColor ??
            MainScreenColorData(
              swatchColor: Colors.amber,
              backgroundColor: Colors.amber.shade400,
            ),
        placesScreenColor = placesScreenColor ??
            MainScreenColorData(
              swatchColor: Colors.amber,
              backgroundColor: Colors.amber.shade400,
            ),
        entertainmentScreenColor = entertainmentScreenColor ??
            MainScreenColorData(
              swatchColor: Colors.amber,
              backgroundColor: Colors.amber.shade400,
            );

  factory ThemeModel.fromMap(Map<String, dynamic> map) {
    return ThemeModel(
      brightness:
          map['brightness'] == "light" ? Brightness.light : Brightness.dark,
      peopleScreenColor:
          MainScreenColorData.fromMap(map[PeopleScreen.themeAttribute]),
      foodScreenColor:
          MainScreenColorData.fromMap(map[FoodScreen.themeAttribute]),
      eventsScreenColor:
          MainScreenColorData.fromMap(map[EventsScreen.themeAttribute]),
      placesScreenColor:
          MainScreenColorData.fromMap(map[PlacesScreen.themeAttribute]),
      entertainmentScreenColor:
          MainScreenColorData.fromMap(map[EntertainmentScreen.themeAttribute]),
    );
  }
  Map<String, dynamic> get toMap => {
        "brightness": brightness == Brightness.light ? "light" : "dark",
        PeopleScreen.themeAttribute: peopleScreenColor.toMap(),
        FoodScreen.themeAttribute: foodScreenColor.toMap(),
        EventsScreen.themeAttribute: eventsScreenColor.toMap(),
        PlacesScreen.themeAttribute: placesScreenColor.toMap(),
        EntertainmentScreen.themeAttribute: entertainmentScreenColor.toMap(),
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
    ];
  }

  ThemeModel copyWith({
    Brightness brightness,
    MainScreenColorData peopleScreenColor,
    MainScreenColorData foodScreenColor,
    MainScreenColorData eventsScreenColor,
    MainScreenColorData placesScreenColor,
    MainScreenColorData entertainmentScreenColor,
  }) {
    return ThemeModel(
      brightness: brightness ?? this.brightness,
      peopleScreenColor: peopleScreenColor ?? this.peopleScreenColor,
      foodScreenColor: foodScreenColor ?? this.foodScreenColor,
      eventsScreenColor: eventsScreenColor ?? this.eventsScreenColor,
      placesScreenColor: placesScreenColor ?? this.placesScreenColor,
      entertainmentScreenColor:
          entertainmentScreenColor ?? this.entertainmentScreenColor,
    );
  }

  @override
  bool get stringify => true;
}
