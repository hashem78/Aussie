import 'package:aussie/constants.dart';
import 'package:aussie/models/efe/efe.dart';
import 'package:aussie/models/efe/food_and_drinks/details.dart';
import 'package:aussie/models/gallery.dart';
import 'package:aussie/models/ratings.dart';
import 'package:aussie/presentation/screens/efe/efe.dart';
import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';
import 'package:aussie/util/social_media_platform.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class FoodAndDrinks extends StatelessWidget {
  final _tempDish = FoodAndDrinksDetailsModel(
      title: "fku",
      titleImageUrl: kurl,
      descriptions: {"hi": klorem},
      ratingModels: [RatingsModel(3, "hashem", klorem)],
      galleryImageLinks: [GalleryImageModel(url: kurl, title: "lol")],
      socialMediaPlatforms: {SocialMediaPlatform.facebook: ""});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AussieAppDrawer(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          AussieSliverAppBar(title: 'Food & Drinks'),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return buildTiles(List.filled(5, _tempDish), index * 100.0);
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
