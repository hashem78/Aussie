import 'package:aussie/models/info/teritory/teritory.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/screen_data.dart';
import 'package:aussie/state/paginated/cubit/paginated_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/models/gmap.dart';
import 'package:aussie/presentation/screens/gmap_screen.dart';
import 'package:aussie/presentation/screens/info/searchable_paginated.dart';
import 'package:aussie/presentation/widgets/paginated/tile.dart';
import 'package:provider/provider.dart';

class TeritoriesScreen extends StatelessWidget {
  static final data = AussieScreenData(
    thumbnailRoute: "teritory_images",
    navPath: "/main/info/teritories",
    svgName: "australia.svg",
    tTitle: "teritoriesTitle",
    themeAttribute: "teritoriesScreenColor",
    dark: AussieColorData(
      swatchColor: Colors.brown.shade800,
      backgroundColor: Colors.brown.shade700,
    ),
    light: AussieColorData(
      swatchColor: Colors.brown.shade500,
      backgroundColor: Colors.brown.shade400,
    ),
  );

  final PaginatedCubit<TeritoryModel> cubit = PaginatedCubit("teritories");
  @override
  Widget build(BuildContext context) {
    var _currentTheme = getCurrentThemeModel(context).teritoriesScreenColor;

    return Provider.value(
      value: _currentTheme,
      child: SearchablePaginatedScreen(
        title: getTranslation(context, TeritoriesScreen.data.tTitle),
        thumbnailCubitRoute: TeritoriesScreen.data.thumbnailRoute,
        cubit: cubit,
        filterFor: "title",
        itemBuilder: (context, item, index) {
          var _casted = item as TeritoryModel;
          return PaginatedScreenTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AussieGMapScreen(
                  model: AussieGMapModel(
                    latitude: _casted.lat,
                    longitude: _casted.lng,
                    title: _casted.city,
                  ),
                ),
              ),
            ),
            title: Text(
              _casted.city,
              style: TextStyle(fontSize: 100.sp, fontWeight: FontWeight.w700),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: buildChip(
                          _currentTheme.swatchColor,
                          getTranslation(context, "population"),
                          _casted.population,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildChip(
                          _currentTheme.swatchColor,
                          getTranslation(context, "longitude"),
                          _casted.lng,
                        ),
                      ),
                      Expanded(
                        child: buildChip(
                          _currentTheme.swatchColor,
                          getTranslation(context, "latitude"),
                          _casted.lat,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildChip(Color chipColor, String title, String value) {
    return SizedBox(
      height: .08.sh,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(horizontal: 5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        color: chipColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 65.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(value),
            )
          ],
        ),
      ),
    );
  }
}

class AussieGMapScreen extends StatelessWidget {
  final AussieGMapModel model;
  const AussieGMapScreen({
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          model.title,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 100.sp),
        ),
        centerTitle: true,
      ),
      body: AussieGMap(
        size: Size(double.infinity, double.infinity),
        model: model,
      ),
    );
  }
}
