import 'package:aussie/models/gallery.dart';
import 'package:aussie/models/main_screen/main_screen_details.dart';
import 'package:aussie/util/social_media_platform.dart';
import 'package:flutter/foundation.dart';

class PeopleDetailsModel extends MainScreenDetailsModel {
  const PeopleDetailsModel({
    @required String title,
    @required String titleImageUrl,
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
  factory PeopleDetailsModel.fromMap(Map<String, dynamic> map) {
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
    var _model = PeopleDetailsModel(
      title: map["title"].toString(),
      titleImageUrl: map["titleImageUrl"].toString(),
      socialMediaPlatforms: _platforms,
      descriptions: Map<String, String>.from(map["descriptions"]),
      galleryImageLinks: _models,
    );

    return _model;
  }
}
