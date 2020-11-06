import 'package:Aussie/constants.dart';
import 'package:Aussie/models/efe/entertainment/details.dart';
import 'package:Aussie/models/gallery.dart';

import 'package:Aussie/models/ratings.dart';
import 'package:Aussie/screens/efe/efe.dart';
import 'package:Aussie/util/social_media_platform.dart';
import 'package:Aussie/widgets/aussie/app_drawer.dart';
import 'package:Aussie/widgets/aussie/sliver_appbar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Entertainment extends StatelessWidget {
  final tmodel = EntertainmentDetailsModel(
      title: "Rabbit Proof",
      titleImageUrl: 'https://tinyurl.com/y3otd7tv',
      galleryImageLinks: [GalleryImageModel(url: kurl, title: "lol")],
      socialMediaPlatforms: {SocialMediaPlatform.facebook: ""},
      descriptions: {"hi": klorem},
      ratingModels: [RatingsModel(3, "hashem", klorem)]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AussieAppDrawer(),
      body: CustomScrollView(
        slivers: [
          AussieSliverAppBar(title: 'Entertainment'),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                buildTiles("Movies", List.filled(5, tmodel)),
                buildTiles("TV Shows", List.filled(5, tmodel)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTiles(String title, List<EntertainmentDetailsModel> models) {
    return EFEScreen.buildEFETiles(
      title,
      models,
      widthFactor: .55.sw,
      heightFactor: .20.sh,
      swatchWidthFactor: 1.sw,
      swatchHeightFactor: .05.sh,
      titleImageHeight: .8.sh,
      listHeightFactor: .6.sh,
      swatchColor: Colors.red,
    );
  }
}
