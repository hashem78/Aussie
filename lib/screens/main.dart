import 'package:Aussie/screens/statistics/info.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/constants.dart';
import 'package:Aussie/screens/efe/efe.dart';
import 'package:Aussie/util/functions.dart';
import 'package:Aussie/widgets/animated/sized_tile.dart';
import 'package:Aussie/widgets/aussie/sliver_appbar.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kausBlue,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool extened) => [
          AussieSliverAppBar(title: "Main", showHero: true),
        ],
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            AnimatedSizedTile.withDetails(
              title: "About famous celebs, the food and what keeps em ticking.",
              swatchMaxLines: 3,
              widthFactor: 100,
              swatchColor: Colors.red,
              heightFactor: 40,
              image: buildImage(kurl).first,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => EFEScreen(),
                ),
              ),
            ),
            SizedBox(height: 1),
            AnimatedSizedTile.withDetails(
              title: "About famous celebs, the food and what keeps em ticking.",
              swatchMaxLines: 3,
              widthFactor: 100,
              swatchColor: Colors.red,
              heightFactor: 40,
              image: buildImage(kurl).first,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => StatisticsScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
