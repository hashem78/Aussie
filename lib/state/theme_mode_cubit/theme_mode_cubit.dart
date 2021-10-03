import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeCubit extends Cubit<ThemeMode> {
  ThemeModeCubit(ThemeMode initialTheme) : super(initialTheme);

  Future<void> changeToLight() async {
    final perfs = await SharedPreferences.getInstance();
    perfs.setString("brightness", "light");

    emit(ThemeMode.light);
  }

  Future<void> changeToDark() async {
    final perfs = await SharedPreferences.getInstance();
    perfs.setString("brightness", "dark");

    emit(ThemeMode.dark);
  }

  Future<void> changeToSystem() async {
    final perfs = await SharedPreferences.getInstance();
    perfs.setString("brightness", "system");

    emit(ThemeMode.system);
  }
}
