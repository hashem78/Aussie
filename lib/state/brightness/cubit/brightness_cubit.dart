import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'brightness_state.dart';

class BrightnessCubit extends Cubit<AussieBrightness> {
  BrightnessCubit(this.currentBrightness) : super(currentBrightness) {
    final SingletonFlutterWindow window = SchedulerBinding.instance.window;
    window.onPlatformBrightnessChanged = () {
      if (currentBrightness == const AussieBrightnessSystem()) {
        final Brightness brightness = window.platformBrightness;
        if (brightness == Brightness.dark) {
          emit(const AussieBrightnessDark());
        } else {
          emit(const AussieBrightnessLight());
        }
      }
    };
  }

  AussieBrightness currentBrightness;

  String get currentBrightnessString {
    return currentBrightness.string;
  }

  Future<void> changeToLight() async {
    final perfs = await SharedPreferences.getInstance();
    perfs.setString("brightness", "light");

    currentBrightness = const AussieBrightnessLight();

    emit(const AussieBrightnessLight());
  }

  Future<void> changeToDark() async {
    final perfs = await SharedPreferences.getInstance();
    perfs.setString("brightness", "dark");

    currentBrightness = const AussieBrightnessDark();

    emit(const AussieBrightnessDark());
  }

  Future<void> changeToSystem() async {
    final perfs = await SharedPreferences.getInstance();
    perfs.setString("brightness", "system");
    currentBrightness = const AussieBrightnessSystem();

    emit(const AussieBrightnessSystem());
  }

  void emitSystem() {
    emit(const AussieBrightnessSystem());
  }
}
