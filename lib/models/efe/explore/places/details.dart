import 'package:aussie/interfaces/ratings.dart';
import 'package:aussie/models/efe/efe.dart';
import 'package:aussie/models/gallery.dart';
import 'package:aussie/presentation/widgets/rating/rating_section.dart';
import 'package:aussie/util/social_media_platform.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlacesDetailsModel extends EFEModel implements RatingsInterface {
  final String id;
  const PlacesDetailsModel({
    @required String title,
    @required String titleImageUrl,
    @required this.id,
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
  Widget buildRatings() => RatingSection(
        id: id,
        titleImageUrl: titleImageUrl,
      );
  factory PlacesDetailsModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    List<GalleryImageModel> _models = [];
    List<dynamic>.from(map["galleryImageLinks"]).forEach(
      (value) {
        var _mp = Map<String, dynamic>.from(value);
        _models.add(GalleryImageModel.fromMap(_mp));
      },
    );
    var _platforms = Map<String, String>.from(map['socialMediaPlatforms'])
        .map<SocialMediaPlatform, String>(
      (key, value) => MapEntry<SocialMediaPlatform, String>(
        key.toSocialMediaPlatform(),
        value,
      ),
    );
    var _model = PlacesDetailsModel(
      title: map["title"].toString(),
      titleImageUrl: map["titleImageUrl"].toString(),
      id: map["id"].toString(),
      socialMediaPlatforms: _platforms,
      descriptions: Map<String, String>.from(map["descriptions"]),
      galleryImageLinks: _models,
    );

    return _model;
  }
}
