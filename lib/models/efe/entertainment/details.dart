import 'package:aussie/interfaces/geners.dart';
import 'package:aussie/interfaces/ratings.dart';
import 'package:aussie/models/efe/efe.dart';
import 'package:aussie/models/gallery.dart';
import 'package:aussie/presentation/widgets/rating/rating_section.dart';
import 'package:aussie/util/social_media_platform.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EntertainmentDetailsModel extends EFEModel
    implements RatingsInterface, GenersInterface {
  final List<String> geners;
  final String id;

  const EntertainmentDetailsModel({
    @required String title,
    this.id,
    @required String titleImageUrl,
    Map<SocialMediaPlatform, String> socialMediaPlatforms,
    Map<String, String> descriptions,
    this.geners,
    List<GalleryImageModel> galleryImageLinks,
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

  @override
  Widget buildGeners() =>
      Text(geners.reduce((value, element) => '$value, $element'));
}
