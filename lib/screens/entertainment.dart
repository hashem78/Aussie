import 'package:Aussie/util/functions.dart';
import 'package:Aussie/util/pair.dart';
import 'package:Aussie/util/social_media_platform.dart';
import 'package:Aussie/widgets/%20aussie_scrollable_list.dart';
import 'package:Aussie/widgets/aussie_sliver_appbar.dart';
import 'package:Aussie/widgets/rating_section.dart';
import 'package:Aussie/widgets/rating_tile.dart';
import 'package:Aussie/widgets/social_icons_row.dart';

import 'package:flutter/material.dart';

import 'package:Aussie/screens/details.dart';
import 'package:Aussie/widgets/animated/banner_image.dart';
import 'package:Aussie/widgets/animated/expanded_text_tile.dart';
import 'package:Aussie/widgets/animated/sized_tile.dart';
import 'package:Aussie/widgets/details_heading.dart';

import '../constants.dart';

var _col = getRandomColor();

class Entertainment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _col,
      child: NestedScrollView(
        physics: ClampingScrollPhysics(),
        headerSliverBuilder: (context, __) => [
          AussieSliverAppBar(
            backgroundColor: _col,
            title: "Entertainment",
            showHero: false,
          )
        ],
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            AussieScrollableList(
              heightFactor: 55,
              childPadding: EdgeInsets.all(5),
              title: "Movies",
              scrollDirection: Axis.horizontal,
              children: [
                buildSizedImageTile(
                  60,
                  20,
                  url: "https://tinyurl.com/yy9emu2q",
                  title: "Rabbit Proof",
                ),
                buildSizedImageTile(
                  60,
                  20,
                  url: "https://tinyurl.com/yy9emu2q",
                  title: "Rabbit Proof",
                ),
              ],
            ),
            AussieScrollableList(
              heightFactor: 50,
              childPadding: EdgeInsets.all(5),
              title: "TV Shows",
              scrollDirection: Axis.horizontal,
              children: [
                buildSizedImageTile(
                  60,
                  20,
                  url: "https://tinyurl.com/yy9emu2q",
                  title: "Went Worth Prision",
                ),
                buildSizedImageTile(
                  60,
                  20,
                  url: "https://tinyurl.com/yy9emu2q",
                  title: "Glitch",
                ),
                buildSizedImageTile(
                  60,
                  20,
                  url: "https://tinyurl.com/yy9emu2q",
                  title: "Secret City",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSizedImageTile(int widthFactor, int heighFactor,
      {String url = "https://tinyurl.com/y5923jao", String title}) {
    var image = buildImage(url);
    return AnimatedSizedImageTile.withDetails(
      swatchColor: Colors.blue,
      widthFactor: widthFactor,
      heightFactor: heighFactor,
      title: title,
      image: image,
      detailsScreen: Details(
        backgroundColor: _col,
        title: title,
        top: AnimatedBannerImage(
          image: image,
          heightFactor: 70,
        ),
        bottom: AussieScrollableList(
          title: "Gallery",
          scrollDirection: Axis.horizontal,
          heightFactor: 50,
          childPadding: EdgeInsets.all(5),
          children: [
            AnimatedSizedImageTile(
              image: image,
              title: "Placeholder",
              widthFactor: 60,
              heightFactor: 20,
              swatchColor: Colors.red,
            ),
            AnimatedSizedImageTile(
              image: image,
              title: "Placeholder",
              widthFactor: 60,
              heightFactor: 20,
              swatchColor: Colors.red,
            ),
          ],
        ),
        sections: [
          Section(
            borderColor: Colors.black,
            children: [
              SocialsIconRow([
                Pair(SocialMediaPlatform.hulu, ""),
                Pair(SocialMediaPlatform.youtubeTV, ""),
                Pair(SocialMediaPlatform.netflix, ""),
                Pair(SocialMediaPlatform.primeVideo, ""),
              ]),
              DetailsHeading(title: title, color: Colors.white),
              AnimatedExpandingTextTile(
                color: Colors.lightBlue,
                title: "What?",
                text: klorem,
              ),
              Text(
                'Generes: Hollywood, Hollywood,Hollywood,Hollywood,',
              )
            ],
          ),
          RatingSection(
            title: "People who've rated this",
            children: [
              RatingTile(
                isReadOnly: true,
                rating: 3,
                owner: "Jhon Posser",
                reviewText: klorem,
                color: getRandomColor(),
              ),
              RatingTile(
                rating: 4,
                owner: "Jhon Posser",
                reviewText: klorem,
                color: getRandomColor(),
              ),
              RatingTile(
                rating: 5,
                owner: "Jhon Posser",
                reviewText: klorem,
                color: getRandomColor(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
