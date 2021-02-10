import 'package:aussie/models/info/species/species_model.dart';
import 'package:aussie/models/themes/color_data_model.dart';
import 'package:aussie/presentation/screens/info/searchable_paginated.dart';
import 'package:aussie/presentation/screens/info/species/details.dart';
import 'package:aussie/presentation/screens/screen_data.dart';

import 'package:aussie/util/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FloraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AussieThemeBuilder(
      dark: AussieScreenColorData.floraDark,
      light: AussieScreenColorData.floraLight,
      builder: (context, color) {
        return SearchablePaginatedScreen<SpeciesDetailsModel>(
          title: getTranslation(context, AussieScreenData.floraTitle),
          thumbnailCubitRoute: AussieScreenData.floraThumbnailRoute,
          filterFor: "commonName",
          itemBuilder: (context, item, index) {
            final _casted = item as SpeciesDetailsModel;
            Widget child;
            if (_casted.imageUrls.isNotEmpty) {
              child = Ink.image(
                image: CachedNetworkImageProvider(
                  _casted.imageUrls.firstWhere((element) => element != null),
                ),
                fit: BoxFit.cover,
              );
            } else {
              child = Center(child: Text(_casted.commonName));
            }
            return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AussieThemeProvider(
                        color: color,
                        child:
                            SpeciesDetails(model: item as SpeciesDetailsModel),
                      ),
                    ),
                  );
                },
                child: child);
          },
        );
      },
    );
  }
}
