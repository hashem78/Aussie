import 'package:Aussie/interfaces/geners.dart';
import 'package:Aussie/interfaces/ratings.dart';
import 'package:Aussie/models/efe/efe.dart';
import 'package:Aussie/models/gallery.dart';
import 'package:Aussie/models/ratings.dart';
import 'package:Aussie/util/social_media_platform.dart';
import 'package:Aussie/widgets/rating/rating_section.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EntertainmentDetailsModel extends EFEModel
    implements RatingsInterface, GenersInterface {
  final List<String> geners;
  final List<RatingsModel> ratingModels;
  const EntertainmentDetailsModel({
    @required String title,
    @required String titleImageUrl,
    Map<SocialMediaPlatform, String> socialMediaPlatforms,
    Map<String, String> descriptions,
    this.geners,
    this.ratingModels,
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

  @override
  Widget buildGeners() =>
      Text(geners.reduce((value, element) => '$value, $element'));
}
