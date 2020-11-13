import 'package:aussie/models/gallery.dart';

import 'package:aussie/util/social_media_platform.dart';

abstract class EFEModel {
  final Map<SocialMediaPlatform, String> socialMediaPlatforms;
  final Map<String, String> descriptions;

  final List<GalleryImageModel> galleryImageLinks;
  final String title;
  final String titleImageUrl;
  const EFEModel({
    this.socialMediaPlatforms,
    this.descriptions,
    this.galleryImageLinks,
    this.title,
    this.titleImageUrl,
  });
}
