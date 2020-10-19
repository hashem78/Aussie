import 'package:Aussie/screens/main.dart';
import 'package:Aussie/util/functions.dart';
import 'package:Aussie/widgets/%20aussie_scrollable_list.dart';
import 'package:Aussie/widgets/aussie_sliver_appbar.dart';
import 'package:Aussie/widgets/rating_section.dart';
import 'package:Aussie/widgets/rating_tile.dart';

import 'package:flutter/material.dart';

import 'package:Aussie/screens/details.dart';
import 'package:Aussie/util/pair.dart';
import 'package:Aussie/util/social_media_platform.dart';
import 'package:Aussie/widgets/animated/banner_image.dart';
import 'package:Aussie/widgets/animated/expanded_text_tile.dart';
import 'package:Aussie/widgets/animated/sized_tile.dart';
import 'package:Aussie/widgets/details_heading.dart';
import 'package:Aussie/widgets/social_icons_row.dart';

import '../constants.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _col = getRandomColor();
    return Container(
      color: _col,
      child: NestedScrollView(
        physics: ClampingScrollPhysics(),
        headerSliverBuilder: (context, __) => [
          AussieSliverAppBar(
            backgroundColor: _col,
            title: EFEScreen.title,
            showHero: false,
          )
        ],
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            AussieScrollableList(
              heightFactor: 32,
              childPadding: EdgeInsets.all(5),
              title: "People",
              scrollDirection: Axis.horizontal,
              children: [
                buildSizedImageTile(70, 20),
                buildSizedImageTile(70, 20),
                buildSizedImageTile(70, 20),
              ],
            ),
            AussieScrollableList(
              title: "Events",
              heightFactor: 40,
              childPadding: EdgeInsets.all(5),
              scrollDirection: Axis.horizontal,
              children: [
                ebuildSizedImageTile(97, 20),
                ebuildSizedImageTile(97, 20),
                ebuildSizedImageTile(97, 20),
              ],
            ),
            AussieScrollableList(
              heightFactor: 32,
              childPadding: EdgeInsets.all(5),
              title: "Places",
              scrollDirection: Axis.horizontal,
              children: [
                pbuildSizedImageTile(70, 20),
                pbuildSizedImageTile(70, 20),
                pbuildSizedImageTile(70, 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget ebuildSizedImageTile(int widthFactor, int heighFactor) {
    var image = buildImage(kurl);
    return AnimatedSizedImageTile.withDetails(
      swatchColor: getRandomColor(),
      widthFactor: widthFactor,
      heightFactor: heighFactor,
      title: "Sydeny Fest",
      image: image,
      detailsScreen: Details(
        title: "Sydney Fest",
        top: AnimatedBannerImage(
          image: image,
          heightFactor: 30,
        ),
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
              SocialsIconRow([
                Pair(SocialMediaPlatform.pintrest, ""),
                Pair(SocialMediaPlatform.googleMaps, ""),
                Pair(SocialMediaPlatform.facebook, ""),
              ]),
              DetailsHeading(title: "Sydeny fest"),
              AnimatedExpandingTextTile(text: klorem, title: "What?"),
              AnimatedExpandingTextTile(
                text: klorem,
                title: "Where?",
                color: Colors.green.shade700,
              ),
            ],
          ),
          RatingSection(
            title: "People who've rated this",
            children: [
              RatingTile(rating: 3, owner: "Jhon Posser", reviewText: klorem),
              RatingTile(rating: 4, owner: "Jhon Posser", reviewText: klorem),
              RatingTile(rating: 5, owner: "Jhon Posser", reviewText: klorem),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildSizedImageTile(int widthFactor, int heighFactor) {
  var image = buildImage(kurl);
  return AnimatedSizedImageTile.withDetails(
    swatchColor: getRandomColor(),
    widthFactor: widthFactor,
    heightFactor: heighFactor,
    title: "PewdiePie",
    image: image,
    detailsScreen: Details(
      title: "pewdiepie",
      top: AnimatedBannerImage(
        image: image,
        heightFactor: 30,
      ),
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

Widget pbuildSizedImageTile(int widthFactor, int heighFactor) {
  var image = buildImage(kurl);
  return AnimatedSizedImageTile.withDetails(
    swatchColor: getRandomColor(),
    widthFactor: widthFactor,
    heightFactor: heighFactor,
    title: "Sydeny's big cathedral",
    image: image,
    detailsScreen: Details(
      title: "Sydney Fest",
      top: AnimatedBannerImage(
        image: image,
        heightFactor: 30,
      ),
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
            SocialsIconRow([
              Pair(SocialMediaPlatform.pintrest, ""),
              Pair(SocialMediaPlatform.googleMaps, ""),
              Pair(SocialMediaPlatform.facebook, ""),
            ]),
            DetailsHeading(title: "Sydeny fest"),
            AnimatedExpandingTextTile(text: klorem, title: "What?"),
            AnimatedExpandingTextTile(
              text: klorem,
              title: "Where?",
              color: Colors.green.shade700,
            ),
          ],
        ),
        RatingSection(
          title: "People who've rated this",
          children: [
            RatingTile(rating: 3, owner: "Jhon Posser", reviewText: klorem),
            RatingTile(rating: 4, owner: "Jhon Posser", reviewText: klorem),
            RatingTile(rating: 5, owner: "Jhon Posser", reviewText: klorem),
          ],
        ),
      ],
    ),
  );
}
