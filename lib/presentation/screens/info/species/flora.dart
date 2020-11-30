import 'package:aussie/models/paginated/species/species.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/screen_data.dart';
import 'package:aussie/presentation/screens/info/species/details.dart';
import 'package:aussie/presentation/screens/searchable_paginated.dart';
import 'package:aussie/presentation/widgets/paginated/tile.dart';
import 'package:aussie/state/paginated/cubit/aussiepaginated_cubit.dart';
import 'package:aussie/util/functions.dart';

import 'package:flutter/material.dart';

class FloraScreen extends StatelessWidget {
  static final data = AussieScreenData(
    navPath: "/main/info/flora",
    svgName: "flora.svg",
    tTitle: "floraTitle",
    themeAttribute: "floraScreenColor",
    dark: AussieColorData(
      swatchColor: Colors.green.shade700,
      backgroundColor: Colors.green.shade600,
    ),
    light: AussieColorData(
      swatchColor: Colors.green.shade400,
      backgroundColor: Colors.green.shade300,
    ),
  );
  final AussiePaginatedCubit cubit = AussiePaginatedCubit("");
  @override
  Widget build(BuildContext context) {
    var _currentTheme = getCurrentThemeModel(context).floraScreenColor;
    return SearchablePaginatedScreen(
      backgroundColor: _currentTheme.backgroundColor,
      title: getTranslation(context, FloraScreen.data.tTitle),
      cubit: cubit,
      thumbnailCubitRoute: "park_images",
      filterFor: "",
      itemBuilder: (context, item, index) {
        var _casted = item as SpeciesDetailsModel;
        return PaginatedScreenTile(
          title: Text(
            _casted.commonName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SpeciesDetails(
                model: item,
                detailsBackgroundColor: _currentTheme.backgroundColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
