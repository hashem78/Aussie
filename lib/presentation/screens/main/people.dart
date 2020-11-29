import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/screen_data.dart';
import 'package:aussie/presentation/screens/main/widgets/aussie_featured_listview.dart';
import 'package:aussie/presentation/screens/main/widgets/aussie_paged_listview.dart';
import 'package:aussie/presentation/widgets/aussie/a_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/models/main_screen/explore/people/details.dart';

import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';

import 'package:aussie/util/functions.dart';

class PeopleScreen extends StatelessWidget {
  static final data = AussieScreenData(
    themeAttribute: "peopleScreenColor",
    title: "People",
    svgName: "people.svg",
    navPath: "/people",
    dark: AussieColorData(
      swatchColor: Colors.blue.shade900,
      backgroundColor: Colors.blue.shade800,
    ),
    light: AussieColorData(
      swatchColor: Colors.blue.shade500,
      backgroundColor: Colors.blue.shade400,
    ),
  );

  @override
  Widget build(BuildContext context) {
    var _currentTheme = getCurrentThemeModel(context);
    var _backgroundColor = _currentTheme.peopleScreenColor.backgroundColor;
    return AussieScaffold(
      drawer: getAppDrawer(context),
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AussieSliverAppBar(
              _currentTheme.peopleScreenColor.swatchColor,
              PeopleScreen.data.title,
            ),
            buildTitle("Featured"),
            AussieFeaturedListView<PeopleDetailsModel>(
              "movies_list",
              (Map<String, dynamic> map) => PeopleDetailsModel.fromMap(map),
              _backgroundColor,
            ),
            buildTitle("More"),
            AussiePagedListView<PeopleDetailsModel>(
              "movies_list",
              (Map<String, dynamic> map) => PeopleDetailsModel.fromMap(map),
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
