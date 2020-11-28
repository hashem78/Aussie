import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/screen_data.dart';
import 'package:aussie/state/paginated/cubit/aussiepaginated_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/models/gmap.dart';
import 'package:aussie/models/paginated/teritories/teritory.dart';
import 'package:aussie/presentation/screens/gmap_screen.dart';
import 'package:aussie/presentation/screens/searchable_paginated.dart';
import 'package:aussie/presentation/widgets/paginated/tile.dart';

class TeritoriesScreen extends StatelessWidget {
  static final data = AussieScreenData(
    navPath: "/main/info/teritories",
    svgName: "australia.svg",
    title: "Teritories",
    themeAttribute: "teritoriesScreenColor",
    dark: AussieColorData(
      swatchColor: Colors.lime.shade700,
      backgroundColor: Colors.lime.shade600,
    ),
    light: AussieColorData(
      swatchColor: Colors.lime.shade400,
      backgroundColor: Colors.lime.shade300,
    ),
  );

  final AussiePaginatedCubit<TeritoryModel> cubit =
      AussiePaginatedCubit("teritories");
  @override
  Widget build(BuildContext context) {
    var _currentTheme = getCurrentThemeModel(context).teritoriesScreenColor;
    return SearchablePaginatedScreen(
      backgroundColor: _currentTheme.backgroundColor,
      title: TeritoriesScreen.data.title,
      thumbnailCubitRoute: "teritory_images",
      cubit: cubit,
      filterFor: "title",
      itemBuilder: (context, item, index) {
        var _casted = item as TeritoryModel;
        return PaginatedScreenTile(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AussieGMapScreen(
                model: AussieGMapModel(
                  latitude: _casted.latitude,
                  longitude: _casted.longitude,
                  title: _casted.title,
                ),
              ),
            ),
          ),
          title: Text(
            _casted.title,
            style: TextStyle(fontSize: 100.sp, fontWeight: FontWeight.w700),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: buildChip(_currentTheme.swatchColor, "Population",
                          _casted.population),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: buildChip(_currentTheme.swatchColor, "Longitude",
                            _casted.longitude)),
                    Expanded(
                        child: buildChip(_currentTheme.swatchColor, "Latitude",
                            _casted.latitude)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildChip(Color chipColor, String title, String value) {
    return SizedBox(
      height: .08.sh,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(horizontal: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
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
