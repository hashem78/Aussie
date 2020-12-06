import 'package:aussie/models/in_aus/explore/events/details.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/screen_data.dart';
import 'package:aussie/presentation/screens/in_aus/widgets/aussie_featured_listview.dart';
import 'package:aussie/presentation/screens/in_aus/widgets/aussie_paged_listview.dart';
import 'package:aussie/presentation/widgets/aussie/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';

import 'package:aussie/util/functions.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatelessWidget {
  static final data = AussieScreenData(
    thumbnailRoute: "teritory_images",
    themeAttribute: "eventScreenColor",
    tTitle: "eventsTitle",
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
    var _currentTheme = getCurrentThemeModel(context).eventsScreenColor;
    var _backgroundColor = _currentTheme.backgroundColor;
    return Provider.value(
      value: _currentTheme,
      child: AussieScaffold(
        drawer: getAppDrawer(context),
        backgroundColor: _backgroundColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              AussieSliverAppBar(
                _currentTheme.swatchColor,
                getTranslation(context, EventsScreen.data.tTitle),
              ),
              AussieFeaturedListView<EventDetailsModel>(
                "movies_list",
                (Map<String, dynamic> map) => EventDetailsModel.fromMap(map),
                //_currentTheme,
              ),
              buildTitle(getTranslation(context, "moreTitle")),
              AussiePagedListView<EventDetailsModel>(
                "movies_list",
                (Map<String, dynamic> map) => EventDetailsModel.fromMap(map),
              ),
            ],
          ),
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
