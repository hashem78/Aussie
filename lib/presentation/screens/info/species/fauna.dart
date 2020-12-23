import 'package:aussie/models/info/species/species.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/screen_data.dart';
import 'package:aussie/presentation/screens/info/searchable_paginated.dart';
import 'package:aussie/presentation/screens/info/species/details.dart';
import 'package:aussie/presentation/widgets/paginated/tile.dart';
import 'package:aussie/state/paginated/cubit/paginated_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class FaunaScreen extends StatelessWidget {
  static final data = AussieScreenData(
    thumbnailRoute: "fauna_images",
    navPath: "/main/info/fauna",
    svgName: "fauna.svg",
    tTitle: "faunaTitle",
    themeAttribute: "faunaScreenColor",
    dark: AussieColorData(
      swatchColor: Colors.brown.shade700,
      backgroundColor: Colors.brown.shade600,
    ),
    light: AussieColorData(
      swatchColor: Colors.brown.shade400,
      backgroundColor: Colors.brown.shade300,
    ),
  );
  final PaginatedCubit cubit = PaginatedCubit<SpeciesDetailsModel>("fauna");
  @override
  Widget build(BuildContext context) {
    final _currentTheme = getCurrentThemeModel(context).faunaScreenColor;

    return Provider.value(
      value: _currentTheme,
      child: SearchablePaginatedScreen(
        title: getTranslation(context, FaunaScreen.data.tTitle),
        cubit: cubit,
        filterFor: "commonName",
        thumbnailCubitRoute: FaunaScreen.data.thumbnailRoute,
        itemBuilder: (context, item, index) {
          final _casted = item as SpeciesDetailsModel;
          return PaginatedScreenTile(
            titleImage: buildImage(_casted.titleImageUrl),
            title: Text(
              _casted.commonName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            onTap: () => Navigator.push(
              context,
              PageTransition(
                child: Provider.value(
                  value: _currentTheme,
                  child: SpeciesDetails(model: item as SpeciesDetailsModel),
                ),
                type: getAppropriateAnimation(context),
              ),
            ),
          );
        },
      ),
    );
  }
}
