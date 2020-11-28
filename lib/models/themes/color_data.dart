import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AussieColorData extends Equatable {
  final Color swatchColor;
  final Color backgroundColor;
  const AussieColorData({
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

  factory AussieColorData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AussieColorData(
      swatchColor: Color(map['swatchColor']),
      backgroundColor: Color(map['backgroundColor']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AussieColorData.fromJson(String source) =>
      AussieColorData.fromMap(json.decode(source));

  AussieColorData copyWith({
    Color swatchColor,
    Color backgroundColor,
  }) {
    return AussieColorData(
      swatchColor: swatchColor ?? this.swatchColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  bool get stringify => true;
}
