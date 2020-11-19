import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:aussie/interfaces/ratings.dart';
import 'package:aussie/models/efe/efe.dart';
import 'package:aussie/models/gallery.dart';
import 'package:aussie/presentation/widgets/rating/rating_section.dart';
import 'package:aussie/util/social_media_platform.dart';

class FoodAndDrinksDetailsModel extends EFEModel implements RatingsInterface {
  final String id;
  const FoodAndDrinksDetailsModel({
    @required String title,
    @required String titleImageUrl,
    Map<SocialMediaPlatform, String> socialMediaPlatforms,
    Map<String, String> descriptions,
    List<GalleryImageModel> galleryImageLinks,
    this.id,
  }) : super(
          title: title,
          titleImageUrl: titleImageUrl,
          socialMediaPlatforms: socialMediaPlatforms,
          descriptions: descriptions,
          galleryImageLinks: galleryImageLinks,
        );
  @override
  Widget buildRatings() => RatingSection(
        id: id,
        titleImageUrl: titleImageUrl,
      );
}
