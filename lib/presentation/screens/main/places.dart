import 'package:aussie/models/main_screen/explore/places/details.dart';
import 'package:aussie/presentation/screens/main/widgets/aussie_featured_listview.dart';
import 'package:aussie/presentation/screens/main/widgets/aussie_paged_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';

import 'package:aussie/util/functions.dart';

class PlacesScreen extends StatelessWidget {
  static final String themeAttribute = "placesScreenColor";
  static final String title = "Places";
  static final String svgName = "places.svg";
  static final String navPath = "/palces";

  @override
  Widget build(BuildContext context) {
    var _currentTheme = getCurrentThemeModel(context);
    var _backgroundColor = _currentTheme.placesScreenColor.backgroundColor;
    return Scaffold(
      drawer: AussieAppDrawer(),
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AussieSliverAppBar(
              _currentTheme.placesScreenColor.swatchColor,
              PlacesScreen.title,
            ),
            buildTitle("Featured"),
            AussieFeaturedListView<PlacesDetailsModel>(
              "movies_list",
              (Map<String, dynamic> map) => PlacesDetailsModel.fromMap(map),
              _backgroundColor,
            ),
            buildTitle("More"),
            AussiePagedListView<PlacesDetailsModel>(
              "movies_list",
              (Map<String, dynamic> map) => PlacesDetailsModel.fromMap(map),
              _backgroundColor,
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
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
