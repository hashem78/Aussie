import 'package:aussie/models/info/species/species_model.dart';
import 'package:aussie/models/themes/color_data_model.dart';
import 'package:aussie/presentation/screens/info/searchable_paginated.dart';
import 'package:aussie/presentation/screens/info/species/details.dart';
import 'package:aussie/presentation/screens/screen_data.dart';
import 'package:aussie/util/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FaunaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AussieThemeBuilder(
      dark: AussieScreenColorData.faunaDark,
      light: AussieScreenColorData.faunaLight,
      builder: (context, color) {
        return SearchablePaginatedScreen<SpeciesDetailsModel>(
          title: getTranslation(context, AussieScreenData.faunaTitle),
          thumbnailCubitRoute: AussieScreenData.faunaThumbnailRoute,
          filterFor: "commonName",
          itemBuilder: (context, item, index) {
            final _casted = item as SpeciesDetailsModel;

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AussieThemeProvider(
                      color: color,
                      child: SpeciesDetails(model: item as SpeciesDetailsModel),
                    ),
                  ),
                );
              },
              child: Ink.image(
                image: CachedNetworkImageProvider(
                  _casted.titleImageUrl,
                ),
                fit: BoxFit.cover,
              ),
            );
          },
        );
      },
    );
  }
}
