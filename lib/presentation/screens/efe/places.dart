import 'package:aussie/constants.dart';
import 'package:aussie/models/efe/efe.dart';

import 'package:aussie/models/efe/explore/places/details.dart';
import 'package:aussie/models/gallery.dart';
import 'package:aussie/presentation/screens/efe/efe.dart';
import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/util/social_media_platform.dart';

class PlacesScreen extends StatelessWidget {
  final _tempPlace = PlacesDetailsModel(
    title: "Sydney Fest",
    titleImageUrl: kurl,
    descriptions: {"hi": klorem},
    id: "rbt",
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
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return buildTiles(List.filled(5, _tempPlace), index * 100.0);
              },
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTiles(List<EFEModel> models, double listScrollOffset) =>
      EFEScreen.buildEFETiles(
        models,
        widthFactor: .7.sw,
        swatchWidthFactor: 1.sw,
        swatchHeightFactor: .04.sh,
        listHeightFactor: .61.sh,
        swatchColor: Colors.red,
        listScrollOffset: listScrollOffset,
      );
}
