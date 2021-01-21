import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class BrightnessCubit extends Cubit<Brightness> {
  BrightnessCubit(Brightness brightness) : super(brightness);

  Brightness currentBrightness = Brightness.light;

  Future<void> changeToLight() async {
    currentBrightness = Brightness.light;
    final perfs = await SharedPreferences.getInstance();
    perfs.setString("brightness", "light");

    emit(Brightness.light);
  }

  Future<void> changeToDark() async {
    currentBrightness = Brightness.dark;
    final perfs = await SharedPreferences.getInstance();
    perfs.setString("brightness", "dark");
    emit(Brightness.dark);
  }

  void toggleBrightness() {
    if (currentBrightness == Brightness.light) {
      changeToDark();
    } else {
      changeToLight();
    }
  }
}
