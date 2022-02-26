import 'dart:convert';
import 'package:evento/constants.dart';
import 'package:evento/models/theme_mode/theme_mode.dart';
import 'package:evento/state/shared_prefrences.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeModeNotifier extends StateNotifier<AThemeMode?> {
  ThemeModeNotifier(AThemeMode initialState, this.ref) : super(initialState);

  final Ref ref;

  void changeTo(AThemeMode? newThemeMode) {
    final prefs = ref.read(sharedPrefrencesProvider);
    if (newThemeMode == kSystemMode) {
      final systemBrightness =
          SchedulerBinding.instance!.window.platformBrightness;
      state = AThemeMode.system(brightness: systemBrightness);
    } else {
      state = newThemeMode;
    }
    prefs.setString('themeMode', jsonEncode(state!.toJson()));
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, AThemeMode?>(
  (Ref ref) {
    final prefs = ref.read(sharedPrefrencesProvider);
    var themeMode = prefs.getString('themeMode');
    if (themeMode == null) {
      themeMode = jsonEncode(kLightMode);
      prefs.setString('themeMode', themeMode);
    }
    final decoded = jsonDecode(themeMode);
    return ThemeModeNotifier(AThemeMode.fromJson(decoded), ref);
  },
);
