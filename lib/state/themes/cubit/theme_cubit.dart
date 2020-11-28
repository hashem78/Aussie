import 'package:aussie/models/themes/themes.dart';
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
    MainScreenColorData peopleScreenColor,
    MainScreenColorData foodScreenColor,
    MainScreenColorData eventsScreenColor,
    MainScreenColorData placesScreenColor,
    MainScreenColorData entertainmentScreenColor,
  }) {
    var _modifiedModel = currentModel.copyWith(
      brightness: brightness,
      peopleScreenColor: peopleScreenColor,
      foodScreenColor: foodScreenColor,
      eventsScreenColor: placesScreenColor,
      placesScreenColor: placesScreenColor,
      entertainmentScreenColor: entertainmentScreenColor,
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
        peopleScreenColor: MainScreenColorData(
          swatchColor: Colors.blue.shade900,
          backgroundColor: Colors.blue.shade800,
        ),
        placesScreenColor: MainScreenColorData(
          swatchColor: Colors.brown.shade900,
          backgroundColor: Colors.brown.shade800,
        ),
        eventsScreenColor: MainScreenColorData(
          swatchColor: Colors.green.shade900,
          backgroundColor: Colors.green.shade800,
        ),
        foodScreenColor: MainScreenColorData(
          swatchColor: Colors.lime.shade700,
          backgroundColor: Colors.lime.shade600,
        ),
      );
    } else {
      changeTheme(
        brightness: Brightness.light,
        peopleScreenColor: MainScreenColorData(
          swatchColor: Colors.blue.shade600,
          backgroundColor: Colors.blue.shade500,
        ),
        placesScreenColor: MainScreenColorData(
          swatchColor: Colors.brown.shade600,
          backgroundColor: Colors.brown.shade500,
        ),
        eventsScreenColor: MainScreenColorData(
          swatchColor: Colors.green.shade600,
          backgroundColor: Colors.green.shade500,
        ),
        foodScreenColor: MainScreenColorData(
          swatchColor: Colors.lime.shade500,
          backgroundColor: Colors.lime.shade400,
        ),
      );
    }
  }

  ThemeModel get currentModel => state.model;
}
