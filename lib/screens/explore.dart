import 'package:Aussie/widgets/%20aussie_scrollable_list.dart';
import 'package:Aussie/widgets/aussie_sliver_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:Aussie/screens/details.dart';
import 'package:Aussie/util/pair.dart';
import 'package:Aussie/util/social_media_platform.dart';
import 'package:Aussie/widgets/animated/banner_image.dart';
import 'package:Aussie/widgets/animated/expanded_text_tile.dart';
import 'package:Aussie/widgets/animated/sized_tile.dart';
import 'package:Aussie/widgets/details_heading.dart';
import 'package:Aussie/widgets/social_icons_row.dart';

import '../constants.dart';
import '../size_config.dart';

class ExploreScreen extends StatelessWidget {
  static final _title = "Explore";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kausBlue,
      body: NestedScrollView(
        physics: ClampingScrollPhysics(),
        headerSliverBuilder: (_, __) => [AussieSliverAppBar(_title)],
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            AussieScrollableList(
              heightFactor: 24,
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
              heightFactor: 34,
              childPadding: EdgeInsets.all(8),
              children: [
                ebuildSizedImageTile(100, 31),
                ebuildSizedImageTile(100, 31),
                ebuildSizedImageTile(100, 31),
              ],
            ),
            AussieScrollableList(
              heightFactor: 24,
              childPadding: EdgeInsets.all(5),
              title: "Places",
              scrollDirection: Axis.horizontal,
              children: [
                pbuildSizedImageTile(62, 20),
                pbuildSizedImageTile(62, 20),
                pbuildSizedImageTile(62, 20),
              ],
            ),
            AussieScrollableList(
              heightFactor: 24,
              childPadding: EdgeInsets.all(5),
              title: "Places",
              scrollDirection: Axis.horizontal,
              children: [
                ebuildSizedImageTile(62, 20),
                ebuildSizedImageTile(62, 20),
                ebuildSizedImageTile(62, 20),
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
      widthFactor: widthFactor,
      heightFactor: heighFactor,
      title: "Sydeny Fest",
      image: image,
      detailsScreen: Details(
        title: "Sydney Fest",
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
          RatingSection(),
        ],
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

Widget pbuildSizedImageTile(int widthFactor, int heighFactor) {
  var image = buildImage(kurl);
  return AnimatedSizedImageTile.withDetails(
    widthFactor: widthFactor,
    heightFactor: heighFactor,
    title: "Sydeny's big cathedral",
    image: image,
    detailsScreen: Details(
      title: "Sydney Fest",
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
        RatingSection(),
      ],
    ),
  );
}

class RatingSection extends StatelessWidget {
  const RatingSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Section(
      children: <Widget>[
        Text(
          "People who've rated this event...",
          //textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        RatingTile(rating: 3, owner: "Jhon Posser", reviewText: klorem),
        RatingTile(rating: 4, owner: "Jhon Posser", reviewText: klorem),
        RatingTile(rating: 5, owner: "Jhon Posser", reviewText: klorem),
      ],
    );
  }
}

class RatingTile extends StatelessWidget {
  final String owner;
  final String reviewText;
  final double rating;
  const RatingTile({
    Key key,
    this.owner,
    this.reviewText,
    this.rating,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: kaussieRadius,
          color: Colors.red.shade600,
          boxShadow: [
            BoxShadow(blurRadius: 10),
          ]),
      child: ListTile(
        title: AnimatedExpandingTextTile(
          title: owner,
          text: reviewText,
          expandedTextColor: Colors.grey,
          color: Colors.transparent,
          titleStyle: TextStyle(fontSize: 30),
          maxLines: 3,
          overflow: TextOverflow.clip,
          showShadow: false,
        ),
        contentPadding: EdgeInsets.zero,
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Rating: "),
            SmoothStarRating(
              rating: rating,
              isReadOnly: false,
              size: 25,
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              defaultIconData: Icons.star_border,
              color: Colors.amber,
              starCount: 5,
              allowHalfRating: true,
              spacing: 2.0,
              onRated: (value) {
                print("rating value -> $value");
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildImage(imageUrl) => CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        color: Colors.lightBlueAccent,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
