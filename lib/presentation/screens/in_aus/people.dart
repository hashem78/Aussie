import 'package:aussie/models/in_aus/explore/people/details.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/screen_data.dart';
import 'package:aussie/presentation/screens/in_aus/widgets/aussie_featured_listview.dart';
import 'package:aussie/presentation/screens/in_aus/widgets/aussie_paged_listview.dart';
import 'package:aussie/presentation/widgets/aussie/scaffold.dart';
import 'package:aussie/presentation/widgets/aussie/thumbnailed_sliver_appbar.dart';
import 'package:aussie/state/thumbnail/cubit/thumbnail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/util/functions.dart';
import 'package:provider/provider.dart';

class PeopleScreen extends StatelessWidget {
  static final data = AussieScreenData(
    thumbnailRoute: "people_images",
    themeAttribute: "peopleScreenColor",
    tTitle: "peopleTitle",
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
    var _currentTheme = getCurrentThemeModel(context).peopleScreenColor;
    var _backgroundColor = _currentTheme.backgroundColor;
    return Provider<AussieColorData>.value(
      value: _currentTheme,
      child: AussieScaffold(
        drawer: getAppDrawer(context),
        backgroundColor: _backgroundColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              AussieThumbnailedSliverAppBar(
                cubit: ThumbnailCubit(PeopleScreen.data.thumbnailRoute),
                title: getTranslation(context, PeopleScreen.data.tTitle),
                height: .7.sh,
              ),
              AussieFeaturedListView<PeopleDetailsModel>(
                "people_list",
                (Map<String, dynamic> map) => PeopleDetailsModel.fromMap(map),
                // _currentTheme,
              ),
              buildTitle(getTranslation(context, "moreTitle")),
              AussiePagedListView<PeopleDetailsModel>(
                "people_list",
                (Map<String, dynamic> map) => PeopleDetailsModel.fromMap(map),
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
