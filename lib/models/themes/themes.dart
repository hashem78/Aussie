import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class ThemeModel extends Equatable {
  final Brightness brightness;
  static final Map<String, dynamic> defaultThemeMap = {
    "brightness": "light",
  };
  ThemeModel({Brightness brightness})
      : brightness = brightness ?? Brightness.light;
  factory ThemeModel.fromMap(Map<String, dynamic> map) {
    return ThemeModel(
      brightness:
          map['brightness'] == "light" ? Brightness.light : Brightness.dark,
    );
  }
  Map<String, dynamic> get toMap => {
        "brightness": brightness == Brightness.light ? "light" : "dark",
      };
  String toJson() => jsonEncode(toMap);

  @override
  List<Object> get props => [brightness];

  ThemeModel copyWith({
    Brightness brightness,
  }) {
    return ThemeModel(
      brightness: brightness ?? this.brightness,
    );
  }
}
