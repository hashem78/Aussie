import 'package:flutter/material.dart';

class AussiePieChartModel {
  final String sectionTitle;
  final Color color;
  final double value;
  final bool animated;
  final bool hasBadge;
  final String indicatorText;
  const AussiePieChartModel({
    this.color = Colors.black,
    this.animated = false,
    this.hasBadge = false,
    this.sectionTitle,
    @required this.value,
    this.indicatorText,
  }) : assert(value != null);
}
