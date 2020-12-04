import 'package:aussie/models/themes/color_data.dart';
import 'package:flutter/foundation.dart';

@immutable
class AussieScreenData {
  final String tTitle;
  final String themeAttribute;
  final String navPath;
  final String svgName;
  final String thumbnailRoute;
  final AussieColorData dark;
  final AussieColorData light;
  const AussieScreenData({
    @required this.tTitle,
    @required this.themeAttribute,
    @required this.navPath,
    @required this.svgName,
    @required this.dark,
    @required this.light,
    @required this.thumbnailRoute,
  }) : assert(
          tTitle != null &&
              themeAttribute != null &&
              navPath != null &&
              svgName != null &&
              dark != null &&
              light != null &&
              thumbnailRoute != null,
        );
}
