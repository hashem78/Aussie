import 'package:aussie/constants.dart';
import 'package:aussie/models/efe/entertainment/details.dart';
import 'package:aussie/models/gallery.dart';

import 'package:aussie/models/ratings.dart';
import 'package:aussie/presentation/screens/efe/efe.dart';
import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';

import 'package:aussie/util/social_media_platform.dart';
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
                buildTiles(0, List.filled(5, tmodel)),
                buildTiles(100, List.filled(5, tmodel)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTiles(
      double initialScrollOffset, List<EntertainmentDetailsModel> models) {
    return EFEScreen.buildEFETiles(
      models,
      widthFactor: .55.sw,
      heightFactor: .20.sh,
      swatchWidthFactor: 1.sw,
      swatchHeightFactor: .05.sh,
      titleImageHeight: .8.sh,
      listHeightFactor: .61.sh,
      swatchColor: Colors.red,
      listScrollOffset: initialScrollOffset,
    );
  }
}
