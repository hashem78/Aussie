import 'package:aussie/models/main_screen/explore/places/details.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/screen_data.dart';
import 'package:aussie/presentation/screens/main/widgets/aussie_featured_listview.dart';
import 'package:aussie/presentation/screens/main/widgets/aussie_paged_listview.dart';
import 'package:aussie/presentation/widgets/aussie/a_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';

import 'package:aussie/util/functions.dart';

class PlacesScreen extends StatelessWidget {
  static final data = const AussieScreenData(
    thumbnailRoute: "flora_images",
    themeAttribute: "placesScreenColor",
    tTitle: "placesTitle",
    svgName: "places.svg",
    navPath: "/palces",
    dark: const AussieColorData(
      swatchColor: const Color(0xff3e2723),
      backgroundColor: const Color(0xff4e342E),
    ),
    light: const AussieColorData(
      swatchColor: const Color(0xff795548),
      backgroundColor: const Color(0xff8d6e63),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var _currentTheme = getCurrentThemeModel(context).placesScreenColor;
    var _backgroundColor = _currentTheme.backgroundColor;
    return AussieScaffold(
      drawer: getAppDrawer(context),
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AussieSliverAppBar(
              _currentTheme.swatchColor,
              getTranslation(context, PlacesScreen.data.tTitle),
            ),
            buildTitle(getTranslation(context, "featuredTitle")),
            AussieFeaturedListView<PlacesDetailsModel>(
              "movies_list",
              (Map<String, dynamic> map) => PlacesDetailsModel.fromMap(map),
              _currentTheme,
            ),
            buildTitle(getTranslation(context, "moreTitle")),
            AussiePagedListView<PlacesDetailsModel>(
              "movies_list",
              (Map<String, dynamic> map) => PlacesDetailsModel.fromMap(map),
              _currentTheme,
            ),
          ],
        ),
      ),
    );
  }

  SliverPadding buildTitle(String title) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 5),
      sliver: SliverToBoxAdapter(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 100.sp,
          ),
        ),
      ),
    );
  }
}
