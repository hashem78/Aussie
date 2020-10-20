import 'package:flutter/material.dart';

class AnimatedPieChartModel {
  final String name;
  final Color color;
  final double value;
  final bool animated;
  final bool hasBadge;
  const AnimatedPieChartModel({
    this.name,
    this.color = Colors.black,
    this.value,
    this.animated = false,
    this.hasBadge = false,
  });
}
