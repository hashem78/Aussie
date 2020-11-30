import 'package:aussie/models/themes/color_data.dart';
import 'package:flutter/foundation.dart';

@immutable
class AussieScreenData {
  final String title;
  final String themeAttribute;
  final String navPath;
  final String svgName;
  final AussieColorData dark;
  final AussieColorData light;
  const AussieScreenData(
      {@required this.title,
      @required this.themeAttribute,
      @required this.navPath,
      @required this.svgName,
      @required this.dark,
      @required this.light})
      : assert(
          title != null &&
              themeAttribute != null &&
              navPath != null &&
              svgName != null &&
              dark != null &&
              light != null,
        );
}