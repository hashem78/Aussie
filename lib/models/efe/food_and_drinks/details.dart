import 'package:aussie/interfaces/ratings.dart';
import 'package:aussie/models/efe/efe.dart';
import 'package:aussie/models/gallery.dart';
import 'package:aussie/models/ratings.dart';
import 'package:aussie/presentation/widgets/rating/rating_section.dart';
import 'package:aussie/util/social_media_platform.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FoodAndDrinksDetailsModel extends EFEModel implements RatingsInterface {
  final List<RatingsModel> ratingModels;
  const FoodAndDrinksDetailsModel({
    @required String title,
    @required String titleImageUrl,
    this.ratingModels,
    Map<SocialMediaPlatform, String> socialMediaPlatforms,
    Map<String, String> descriptions,
    List<GalleryImageModel> galleryImageLinks,
  }) : super(
          title: title,
          titleImageUrl: titleImageUrl,
          socialMediaPlatforms: socialMediaPlatforms,
          descriptions: descriptions,
          galleryImageLinks: galleryImageLinks,
        );
  @override
  Widget buildRatings() => RatingSection(models: ratingModels);
}
