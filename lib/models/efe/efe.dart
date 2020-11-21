import 'package:aussie/models/gallery.dart';

import 'package:aussie/util/social_media_platform.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class EFEModel extends Equatable {
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
  @override
  List<Object> get props => [
        socialMediaPlatforms,
        descriptions,
        galleryImageLinks,
        title,
        titleImageUrl,
      ];
}
