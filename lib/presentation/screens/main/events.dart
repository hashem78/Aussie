import 'package:aussie/models/main_screen/explore/events/details.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/screen_data.dart';
import 'package:aussie/presentation/screens/main/widgets/aussie_featured_listview.dart';
import 'package:aussie/presentation/screens/main/widgets/aussie_paged_listview.dart';
import 'package:aussie/presentation/widgets/aussie/a_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';

import 'package:aussie/util/functions.dart';

class EventsScreen extends StatelessWidget {
  static final data = AussieScreenData(
    themeAttribute: "eventScreenColor",
    title: "Events",
    svgName: "events.svg",
    navPath: "/events",
    dark: AussieColorData(
      swatchColor: Colors.lightGreen.shade700,
      backgroundColor: Colors.lightGreen.shade600,
    ),
    light: AussieColorData(
      swatchColor: Colors.lightGreen.shade400,
      backgroundColor: Colors.lightGreen.shade300,
    ),
  );

  @override
  Widget build(BuildContext context) {
    var _currentTheme = getCurrentThemeModel(context);
    var _backgroundColor = _currentTheme.eventsScreenColor.backgroundColor;
    return AussieScaffold(
      drawer: getAppDrawer(context),
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AussieSliverAppBar(
              _currentTheme.eventsScreenColor.swatchColor,
              EventsScreen.data.title,
            ),
            buildTitle("Featured"),
            AussieFeaturedListView<EventDetailsModel>(
              "movies_list",
              (Map<String, dynamic> map) => EventDetailsModel.fromMap(map),
              _backgroundColor,
            ),
            buildTitle("More"),
            AussiePagedListView<EventDetailsModel>(
              "movies_list",
              (Map<String, dynamic> map) => EventDetailsModel.fromMap(map),
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
          ),
        ),
      ),
    );
  }
}
