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

class FloraScreen extends StatelessWidget {
  static final data = AussieScreenData(
    thumbnailRoute: "flora_images",
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
  final PaginatedCubit cubit = PaginatedCubit<SpeciesDetailsModel>("flora");
  @override
  Widget build(BuildContext context) {
    final _currentTheme = getCurrentThemeModel(context).floraScreenColor;
    return Provider.value(
      value: _currentTheme,
      child: SearchablePaginatedScreen(
        title: getTranslation(context, FloraScreen.data.tTitle),
        cubit: cubit,
        thumbnailCubitRoute: "flora_images",
        filterFor: "commonName",
        itemBuilder: (context, item, index) {
          final _casted = item as SpeciesDetailsModel;
          return PaginatedScreenTile(
            color: _currentTheme.swatchColor,
            titleImage: buildImage(
              _casted.imageUrls.isNotEmpty ? _casted.imageUrls[0] : null,
              fit: BoxFit.cover,
            ),
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
