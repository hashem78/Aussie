import 'package:flutter/material.dart';

class AnimatedPieChartModel {
  final String name;
  final Color color;
  final double value;
  final bool animated;
  final bool hasBadge;
  const AnimatedPieChartModel({
    this.color = Colors.black,
    this.animated = false,
    this.hasBadge = false,
    @required this.name,
    @required this.value,
  }) : assert(name != null && value != null);
}
