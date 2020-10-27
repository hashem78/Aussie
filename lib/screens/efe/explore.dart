import 'package:Aussie/constants.dart';
import 'package:Aussie/models/efe/explore/events/details.dart';
import 'package:Aussie/models/efe/explore/people/details.dart';
import 'package:Aussie/models/efe/explore/places/details.dart';
import 'package:Aussie/models/gallery.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/models/ratings.dart';
import 'package:Aussie/screens/efe/efe.dart';
import 'package:Aussie/util/functions.dart';
import 'package:Aussie/util/social_media_platform.dart';
import 'package:Aussie/widgets/aussie/sliver_appbar.dart';

class ExploreScreen extends StatelessWidget {
  final _tempEvent = EventDetailsModel(
      title: "fku",
      titleImageUrl: kurl,
      descriptions: {"hi": klorem},
      ratingModels: [RatingsModel(3, "hashem", klorem)],
      galleryImageLinks: [GalleryImageModel(url: kurl, title: "lol")],
      socialMediaPlatforms: {SocialMediaPlatform.facebook: ""});
  final _tempPerson = PeopleDetailsModel(
    title: "Pewdiepie",
    titleImageUrl: kurl,
    descriptions: {"hi": klorem},
    galleryImageLinks: [GalleryImageModel(url: kurl, title: "lol")],
    socialMediaPlatforms: {SocialMediaPlatform.facebook: ""},
  );
  final _tempPlace = PlacesDetailsModel(
    title: "Sydney Fest",
    titleImageUrl: kurl,
    descriptions: {"hi": klorem},
    ratingModels: [RatingsModel(3, "hashem", klorem)],
    galleryImageLinks: [GalleryImageModel(url: kurl, title: "lol")],
    socialMediaPlatforms: {SocialMediaPlatform.facebook: ""},
  );
  @override
  Widget build(BuildContext context) {
    var _col = getRandomColor();
    return Scaffold(
      backgroundColor: _col,
      body: NestedScrollView(
        floatHeaderSlivers: true,
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
            EFEScreen.buildEFETiles(
                "People", List.filled(5, _tempPerson), 80, 20, 36),
            EFEScreen.buildEFETiles(
                "Events", List.filled(5, _tempEvent), 90, 20, 42),
            EFEScreen.buildEFETiles(
                "Places", List.filled(5, _tempPlace), 80, 20, 36),
          ],
        ),
      ),
    );
  }
}
