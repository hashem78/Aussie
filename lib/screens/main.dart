import 'package:Aussie/screens/info/info.dart';
import 'package:Aussie/screens/statistics/statistics.dart';
import 'package:Aussie/widgets/sized_tile.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/constants.dart';
import 'package:Aussie/screens/efe/efe.dart';
import 'package:Aussie/util/functions.dart';
import 'package:Aussie/widgets/aussie/sliver_appbar.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kausBlue,
      body: CustomScrollView(
        slivers: [
          AussieSliverAppBar(title: "Main", showHero: true),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                buildTile(
                  "About famous celebs, the food and what keeps em ticking.",
                  EFEScreen.navPath,
                ),
                buildTile(
                  "General statistics ranging from religion to the economy and education",
                  StatisticsScreen.navPath,
                ),
                buildTile(
                  "Get to know more about Australia",
                  InfoScreen.navPath,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTile(String title, String route) => Builder(
        builder: (BuildContext context) => SizedTile.withDetails(
          title: "About famous celebs, the food and what keeps em ticking.",
          swatchMaxLines: 2,
          widthFactor: 100,
          swatchColor: Colors.red,
          heightFactor: 40,
          image: buildImage(kurl),
          onTap: () => Navigator.of(context).pushNamed(route),
        ),
      );
}
