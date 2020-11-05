import 'package:Aussie/screens/info/info.dart';
import 'package:Aussie/screens/statistics/statistics.dart';
import 'package:Aussie/widgets/sized_tile.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/constants.dart';
import 'package:Aussie/screens/efe/efe.dart';
import 'package:Aussie/util/functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            expandedHeight: .6.sh,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              stretchModes: [
                StretchMode.fadeTitle,
              ],
              background: Container(
                color: Colors.red,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 5,
                ),
                buildTile(
                  "About famous celebs, the food and what keeps em ticking.",
                  EFEScreen.navPath,
                ),
                SizedBox(
                  height: 5,
                ),
                buildTile(
                  "General statistics ranging from religion to the economy and education",
                  StatisticsScreen.navPath,
                ),
                SizedBox(
                  height: 5,
                ),
                buildTile(
                  "Get to know more about Australia",
                  InfoScreen.navPath,
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTile(String title, String route) => Builder(
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SizedTile.withDetails(
            title: title,
            swatchMaxLines: 2,
            swatchColor: Colors.transparent,
            widthFactor: .8.sw,
            heightFactor: .40.sh,
            swatchHeightFactor: .1.sh,
            image: buildImage(kurl),
            onTap: () => Navigator.of(context).pushNamed(route),
          ),
        ),
      );
}
