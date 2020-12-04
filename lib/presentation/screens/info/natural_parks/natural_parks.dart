import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/screen_data.dart';
import 'package:aussie/presentation/screens/info/natural_parks/details.dart';
import 'package:aussie/presentation/widgets/paginated/natural_parks_tile.dart';
import 'package:aussie/state/paginated/cubit/aussiepaginated_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:aussie/models/paginated/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/searchable_paginated.dart';

class NaturalParksScreen extends StatelessWidget {
  static AussieScreenData data = const AussieScreenData(
    thumbnailRoute: "park_images",
    tTitle: "naturalParksTitle",
    themeAttribute: "naturalParksScreenColor",
    navPath: "/main/info/naturalParks",
    svgName: "parks.svg",
    dark: const AussieColorData(
      swatchColor: const Color(0xff0d47a1),
      backgroundColor: const Color(0xff1565c0),
    ),
    light: const AussieColorData(
      swatchColor: const Color(0xff0d47a1),
      backgroundColor: const Color(0xff1565c0),
    ),
  );
  final AussiePaginatedCubit<NaturalParkModel> cubit =
      AussiePaginatedCubit("naturalParks");
  @override
  Widget build(BuildContext context) {
    var _currentTheme = getCurrentThemeModel(context).naturalParksScreenColor;
    return SearchablePaginatedScreen(
      appBarColor: _currentTheme.swatchColor,
      backgroundColor: _currentTheme.backgroundColor,
      cubit: cubit,
      title: getTranslation(context, data.tTitle),
      filterFor: "park_name",
      thumbnailCubitRoute: NaturalParksScreen.data.thumbnailRoute,
      itemBuilder: (context, item, index) {
        var _casted = item as NaturalParkModel;
        var _key = UniqueKey();
        return NaturalParksTile(
          heroTag: _key.toString(),
          model: _casted,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return NaturalParksDetailsScreen(
                  backgroundColor: _currentTheme.backgroundColor,
                  heroTag: _key.toString(),
                  model: _casted,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
