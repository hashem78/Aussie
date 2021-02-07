import 'package:aussie/models/info/species/species.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/presentation/screens/info/searchable_paginated.dart';
import 'package:aussie/presentation/screens/info/species/details.dart';
import 'package:aussie/presentation/screens/screen_data.dart';
import 'package:aussie/presentation/widgets/paginated/tile.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class FaunaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AussieThemeBuilder(
      dark: AussieScreenColorData.faunaDark,
      light: AussieScreenColorData.faunaLight,
      builder: (context, color) {
        return SearchablePaginatedScreen<SpeciesDetailsModel>(
          title: getTranslation(context, AussieScreenData.faunaTitle),
          filterFor: "commonName",
          thumbnailCubitRoute: AussieScreenData.faunaThumbnailRoute,
          itemBuilder: (context, item, index) {
            final _casted = item as SpeciesDetailsModel;
            return PaginatedScreenTile(
              titleImage: buildImage(
                _casted.titleImageUrl,
                fit: BoxFit.cover,
              ),
              title: Text(
                _casted.commonName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              onTap: () => Navigator.push(
                context,
                PageTransition(
                  child: AussieThemeProvider(
                    color: color,
                    child: SpeciesDetails(model: item as SpeciesDetailsModel),
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
