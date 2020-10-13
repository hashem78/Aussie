import 'package:Aussie/widgets/%20aussie_scrollable_list.dart';
import 'package:Aussie/widgets/animated_sized_tile.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kausBlue,
      body: NestedScrollView(
        physics: ClampingScrollPhysics(),
        headerSliverBuilder: (_, __) {
          return <Widget>[
            SliverAppBar(
              elevation: 0,
              backgroundColor: kausBlue,
              title: Text("Explore"),
              centerTitle: true,
              actions: [
                Hero(
                  tag: "auFlag",
                  child: Image.asset('assests/images/au.png'),
                ),
              ],
            ),
          ];
        },
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            AussieScrollableList(
              height: 24 * SizeConfig.blockSizeVertical,
              childPadding: EdgeInsets.all(5),
              title: "People",
              scrollDirection: Axis.horizontal,
              children: [
                buildSizedImageTile(62, 20),
                buildSizedImageTile(62, 20),
                buildSizedImageTile(62, 20),
              ],
            ),
            AussieScrollableList(
              title: "Events",
              height: 32 * SizeConfig.blockSizeVertical,
              childPadding:
                  EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
              children: [
                buildSizedImageTile(100, 29),
                buildSizedImageTile(100, 29),
                buildSizedImageTile(100, 29),
              ],
            ),
            AussieScrollableList(
              height: 24 * SizeConfig.blockSizeVertical,
              childPadding: EdgeInsets.all(5),
              title: "Places",
              scrollDirection: Axis.horizontal,
              children: [
                buildSizedImageTile(62, 20),
                buildSizedImageTile(62, 20),
                buildSizedImageTile(62, 20),
              ],
            ),
            AussieScrollableList(
              height: 24 * SizeConfig.blockSizeVertical,
              childPadding: EdgeInsets.all(5),
              title: "Places",
              scrollDirection: Axis.horizontal,
              children: [
                buildSizedImageTile(62, 20),
                buildSizedImageTile(62, 20),
                buildSizedImageTile(62, 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSizedImageTile(int widthFactor, int heighFactor) {
    return AnimatedSizedImageTile(
      widthFactor: widthFactor,
      heightFactor: heighFactor,
      title: "PewdiePie",
      imageUrl:
          'https://www.minecraft.net/content/dam/games/minecraft/screenshots/plains-carousel%20(5).jpg',
    );
  }
}
