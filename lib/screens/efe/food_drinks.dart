import 'package:Aussie/constants.dart';
import 'package:Aussie/models/efe/food_and_drinks/details.dart';
import 'package:Aussie/models/gallery.dart';
import 'package:Aussie/models/ratings.dart';
import 'package:Aussie/screens/efe/efe.dart';
import 'package:Aussie/util/social_media_platform.dart';
import 'package:Aussie/widgets/aussie/sliver_appbar.dart';
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
      backgroundColor: Colors.green,
      body: NestedScrollView(
        physics: ClampingScrollPhysics(),
        headerSliverBuilder: (context, __) => [
          AussieSliverAppBar(
            backgroundColor: Colors.green,
            title: "Food & drinks",
            showHero: false,
          )
        ],
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            EFEScreen.buildEFETiles(
                "Dishes", List.filled(5, _tempDish), 100, 20, 40),
            EFEScreen.buildEFETiles(
                "Drinks & Beverages", List.filled(5, _tempDish), 100, 20, 40),
            EFEScreen.buildEFETiles(
                "Local Cuisine", List.filled(5, _tempDish), 100, 20, 40),
          ],
        ),
      ),
    );
  }
}
