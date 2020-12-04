import 'package:aussie/interfaces/ratings.dart';

import 'package:aussie/models/main_screen/main_screen_details.dart';
import 'package:aussie/presentation/widgets/rating/rating_section.dart';
import 'package:aussie/util/functions.dart';
import 'package:aussie/util/social_media_platform.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FoodAndDrinksDetailsModel extends MainScreenDetailsModel
    implements RatingsInterface {
  final String id;
  const FoodAndDrinksDetailsModel({
    @required String title,
    @required String titleImageUrl,
    Map<SocialMediaPlatform, String> socialMediaPlatforms,
    Map<String, String> descriptions,
    List<String> imageLinks,
    this.id,
  }) : super(
          title: title,
          socialMediaPlatforms: socialMediaPlatforms,
          descriptions: descriptions,
          imageLinks: imageLinks,
        );
  @override
  Widget buildRatings(BuildContext context) => RatingSection(
        id: id,
        imageLinks: imageLinks,
        ratingsBackgroundColor:
            getCurrentThemeModel(context).foodScreenColor.backgroundColor,
      );
  factory FoodAndDrinksDetailsModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    var _platforms = Map<String, String>.from(map['socialMediaPlatforms'])
        .map<SocialMediaPlatform, String>(
      (key, value) => MapEntry<SocialMediaPlatform, String>(
        key.toSocialMediaPlatform(),
        value,
      ),
    );
    var _model = FoodAndDrinksDetailsModel(
      title: map["title"].toString(),
      titleImageUrl: map["titleImageUrl"].toString(),
      id: map["id"].toString(),
      socialMediaPlatforms: _platforms,
      descriptions: Map<String, String>.from(map["descriptions"]),
      imageLinks: List<String>.from(map["imageLinks"]),
    );

    return _model;
  }
}
