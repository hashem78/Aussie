import 'package:aussie/constants.dart';
import 'package:aussie/models/efe/efe.dart';

import 'package:aussie/models/efe/explore/people/details.dart';
import 'package:aussie/models/gallery.dart';
import 'package:aussie/presentation/screens/efe/efe.dart';
import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/util/social_media_platform.dart';

class PeopleScreen extends StatelessWidget {
  final _tempPerson = PeopleDetailsModel(
    title: "Pewdiepie",
    titleImageUrl: kurl,
    descriptions: {"hi": klorem},
    galleryImageLinks: [
      GalleryImageModel(url: kurl, title: "lol"),
      GalleryImageModel(url: kurl, title: "lol"),
      GalleryImageModel(url: kurl, title: "lol")
    ],
    socialMediaPlatforms: {SocialMediaPlatform.facebook: ""},
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AussieAppDrawer(),
      body: CustomScrollView(
        slivers: [
          AussieSliverAppBar(title: 'People'),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return buildTiles(List.filled(5, _tempPerson), index * 100.0);
              },
              childCount: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTiles(List<EFEModel> models, double listScrollOffset) =>
      EFEScreen.buildEFETiles(
        models,
        widthFactor: .8.sw,
        swatchWidthFactor: 1.sw,
        swatchHeightFactor: .04.sh,
        listHeightFactor: .4.sh,
        swatchColor: Colors.lightBlue,
        listScrollOffset: listScrollOffset,
      );
}
