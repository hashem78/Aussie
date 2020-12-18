import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/themes.dart';
import 'package:aussie/presentation/screens/info/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/info/species/fauna.dart';
import 'package:aussie/presentation/screens/info/species/flora.dart';
import 'package:aussie/presentation/screens/info/teritories/teritories.dart';
import 'package:aussie/presentation/screens/info/weather/weather.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(Map<String, dynamic> themeMap)
      : super(ThemeChanged(ThemeModel.fromMap(themeMap)));
  void changeTheme({
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
    var _modifiedModel = currentModel.copyWith(
      brightness: brightness,
      faunaScreenColor: faunaScreenColor,
      floraScreenColor: floraScreenColor,
      teritoriesScreenColor: teritoriesScreenColor,
      weatherScreenColor: weatherScreenColor,
      naturalParksScreenColor: naturalParksScreenColor,
      dykScreenColor: dykScreenColor,
    );
    SharedPreferences.getInstance().then(
      (perfs) {
        perfs.setString("theme", _modifiedModel.toJson());
        emit(ThemeChanged(_modifiedModel));
      },
    );
  }

  void toggleBrightness() {
    final Brightness _currentBrightness = currentModel.brightness;
    if (_currentBrightness == Brightness.light) {
      changeTheme(
        brightness: Brightness.dark,
        faunaScreenColor: FaunaScreen.data.dark,
        floraScreenColor: FloraScreen.data.dark,
        teritoriesScreenColor: TeritoriesScreen.data.dark,
        weatherScreenColor: WeatherScreen.data.dark,
        naturalParksScreenColor: NaturalParksScreen.data.dark,
      );
    } else {
      changeTheme(
        brightness: Brightness.light,
        faunaScreenColor: FaunaScreen.data.light,
        floraScreenColor: FloraScreen.data.light,
        teritoriesScreenColor: TeritoriesScreen.data.light,
        weatherScreenColor: WeatherScreen.data.light,
        naturalParksScreenColor: NaturalParksScreen.data.light,
      );
    }
  }

  ThemeModel get currentModel => state.model;
}
