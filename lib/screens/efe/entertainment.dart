import 'package:Aussie/constants.dart';
import 'package:Aussie/models/efe/entertainment/details.dart';
import 'package:Aussie/models/gallery.dart';

import 'package:Aussie/models/ratings.dart';
import 'package:Aussie/screens/efe/efe.dart';
import 'package:Aussie/util/social_media_platform.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/util/functions.dart';

import 'package:Aussie/widgets/aussie/sliver_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var _col = getRandomColor();

class Entertainment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var tmodel = EntertainmentDetailsModel(
        title: "Rabbit Proof",
        titleImageUrl: 'https://tinyurl.com/y3otd7tv',
        galleryImageLinks: [GalleryImageModel(url: kurl, title: "lol")],
        socialMediaPlatforms: {SocialMediaPlatform.facebook: ""},
        descriptions: {"hi": klorem},
        ratingModels: [RatingsModel(3, "hashem", klorem)]);
    return Scaffold(
      backgroundColor: _col,
      body: NestedScrollView(
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
            EFEScreen.buildEFETiles(
              "Movies",
              List.filled(5, tmodel),
              60,
              20,
              55,
              titleImageHeight: 500.h,
            ),
            EFEScreen.buildEFETiles(
              "TV Shows",
              List.filled(5, tmodel),
              60,
              20,
              50,
              titleImageHeight: 500.h,
            ),
          ],
        ),
      ),
    );
  }
}
