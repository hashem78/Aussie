import 'package:Aussie/constants.dart';
import 'package:Aussie/models/efe/efe.dart';

import 'package:Aussie/models/efe/explore/places/details.dart';
import 'package:Aussie/models/gallery.dart';
import 'package:Aussie/widgets/aussie/app_drawer.dart';
import 'package:Aussie/widgets/aussie/sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Aussie/models/ratings.dart';
import 'package:Aussie/screens/efe/efe.dart';
import 'package:Aussie/util/social_media_platform.dart';

class PlacesScreen extends StatelessWidget {
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
    return Scaffold(
      drawer: AussieAppDrawer(),
      body: CustomScrollView(
        slivers: [
          AussieSliverAppBar(title: 'Places'),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                buildTiles(
                  "People",
                  List.filled(5, _tempPlace),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTiles(String title, List<EFEModel> models) =>
      EFEScreen.buildEFETiles(
        title,
        models,
        widthFactor: .7.sw,
        swatchWidthFactor: 1.sw,
        swatchHeightFactor: .03.sh,
        listHeightFactor: .6.sh,
      );
}
