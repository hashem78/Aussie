import 'package:Aussie/util/pair.dart';
import 'package:Aussie/util/social_media_platform.dart';
import 'package:Aussie/widgets/%20aussie_scrollable_list.dart';
import 'package:Aussie/widgets/animated/banner_image.dart';
import 'package:Aussie/widgets/animated/expanded_text_tile.dart';
import 'package:Aussie/widgets/animated/sized_tile.dart';
import 'package:Aussie/widgets/aussie_sliver_appbar.dart';
import 'package:Aussie/widgets/details_heading.dart';
import 'package:Aussie/widgets/social_icons_row.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'details.dart';
import 'main.dart';

class FoodNDrinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kausBlue,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          AussieSliverAppBar(
            title: "Food & Drinks",
            showHero: false,
          )
        ],
        body: ListView(
          children: [
            AussieScrollableList(
              title: "Local Resturants",
              scrollDirection: Axis.horizontal,
              childPadding: EdgeInsets.all(5),
              children: [
                buildSizedImageTile(97, 30),
              ],
              heightFactor: 36,
            )
          ],
        ),
      ),
    );
  }
}

Widget buildSizedImageTile(int widthFactor, int heighFactor) {
  var image = buildImage(kurl);
  return AnimatedSizedImageTile.withDetails(
    widthFactor: widthFactor,
    heightFactor: heighFactor,
    title: "PewdiePie",
    image: image,
    detailsScreen: Details(
      title: "pewdiepie",
      top: AnimatedBannerImage(image: image),
      bottom: AussieScrollableList(
        title: "Gallery",
        scrollDirection: Axis.horizontal,
        heightFactor: 36,
        childPadding: EdgeInsets.all(5),
        children: [
          AnimatedSizedImageTile(
            image: image,
            title: "Placeholder",
            widthFactor: 97,
            heightFactor: 26,
          ),
          AnimatedSizedImageTile(
            image: image,
            title: "Placeholder",
            widthFactor: 97,
            heightFactor: 26,
          ),
        ],
      ),
      sections: [
        Section(
          children: [
            SocialsIconRow(
              [
                Pair(SocialMediaPlatform.facebook, "https://google.com"),
                Pair(SocialMediaPlatform.instagram, "https://google.com"),
                Pair(SocialMediaPlatform.twitter, "https://google.com"),
                Pair(SocialMediaPlatform.snapchat, "https://google.com"),
                Pair(SocialMediaPlatform.twitch, "https://google.com"),
                Pair(SocialMediaPlatform.youtube, "https://google.com"),
                Pair(SocialMediaPlatform.tiktok, "https://google.com")
              ],
            ),
            DetailsHeading(title: "Pewdiepie"),
            AnimatedExpandingTextTile(
              title: "Who?",
              text: klorem,
            ),
            AnimatedExpandingTextTile(
              title: "Who?",
              text: klorem,
            ),
          ],
        )
      ],
    ),
  );
}
