import 'package:Aussie/constants.dart';
import 'package:Aussie/models/efe/food_and_drinks/details.dart';
import 'package:Aussie/models/gallery.dart';
import 'package:Aussie/models/ratings.dart';
import 'package:Aussie/screens/efe/efe.dart';
import 'package:Aussie/util/social_media_platform.dart';
import 'package:Aussie/widgets/aussie/app_drawer.dart';
import 'package:Aussie/widgets/aussie/sliver_appbar.dart';
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
            delegate: SliverChildListDelegate(
              [
                buildTiles(
                  "Dishes",
                  List.filled(5, _tempDish),
                ),
                buildTiles(
                  "Drinks & Beverages",
                  List.filled(5, _tempDish),
                ),
                buildTiles(
                  "Local Cuisine",
                  List.filled(5, _tempDish),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTiles(String title, List<FoodAndDrinksDetailsModel> models) =>
      EFEScreen.buildEFETiles(
        title,
        models,
        widthFactor: .7.sw,
        swatchWidthFactor: 1.sw,
        swatchHeightFactor: .03.sh,
        listHeightFactor: .6.sh,
      );
}
