import 'package:aussie/models/efe/efe.dart';
import 'package:aussie/models/gallery.dart';
import 'package:aussie/util/social_media_platform.dart';
import 'package:flutter/foundation.dart';

class PeopleDetailsModel extends EFEModel {
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
}
