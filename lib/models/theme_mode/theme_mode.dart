import 'package:aussie/aussie_imports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'theme_mode.freezed.dart';

part 'theme_mode.g.dart';

@freezed
class AThemeMode with _$AThemeMode {
  const factory AThemeMode.dark({
    @Default(ThemeMode.dark) ThemeMode mode,
    @Default(Brightness.dark) Brightness brightness,
    @Default('brightnessDarkTitle') String translationKey,
  }) = _AThemeModeDark;
  const factory AThemeMode.light({
    @Default(ThemeMode.light) ThemeMode mode,
    @Default(Brightness.light) Brightness brightness,
    @Default('brightnessLightTitle') String translationKey,
  }) = _AThemeModeLight;
  const factory AThemeMode.system({
    @Default(ThemeMode.system) ThemeMode mode,
    @Default(Brightness.light) Brightness brightness,
    @Default('brightnessSystemTitle') String translationKey,
  }) = _AThemeModeSystem;
  factory AThemeMode.fromJson(Map<String, dynamic> json) =>
      _$AThemeModeFromJson(json);
}
