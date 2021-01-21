import 'package:aussie/models/info/natural_parks/natural_parks.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/presentation/screens/info/natural_parks/details.dart';
import 'package:aussie/presentation/screens/info/searchable_paginated.dart';
import 'package:aussie/presentation/screens/screen_data.dart';
import 'package:aussie/presentation/widgets/paginated/natural_parks_tile.dart';

import 'package:aussie/util/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NaturalParksScreen extends StatelessWidget {
  const NaturalParksScreen();
  @override
  Widget build(BuildContext context) {
    return AussieThemeBuilder(
      dark: AussieScreenColorData.naturalParksDark,
      light: AussieScreenColorData.naturalParksLight,
      builder: (context, swatchColor, backgroundColor) {
        return SearchablePaginatedScreen<NaturalParkModel>(
          title: getTranslation(context, AussieScreenData.naturalParksTitle),
          filterFor: "park_name",
          thumbnailCubitRoute: AussieScreenData.naturalParksThumbnailRoute,
          itemBuilder: (_, item, index) {
            final _casted = item as NaturalParkModel;
            final _key = UniqueKey();
            return NaturalParksTile(
              heroTag: _key.toString(),
              model: _casted,
              onTap: () => Navigator.of(context).push(
                PageTransition(
                  child: NaturalParksDetailsScreen(
                    heroTag: _key.toString(),
                    model: _casted,
                    swatchColor:
                        AussieThemeProvider.of(context).color.swatchColor,
                    backgroundColor:
                        AussieThemeProvider.of(context).color.backgroundColor,
                  ),
                  type: getAppropriateAnimation(context),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
