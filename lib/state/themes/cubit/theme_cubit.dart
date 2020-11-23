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
  }) {
    var _modifiedModel = currentModel.copyWith(
      brightness: brightness,
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
      changeTheme(brightness: Brightness.dark);
    } else {
      changeTheme(brightness: Brightness.light);
    }
  }

  ThemeModel get currentModel => state.model;
}
