import 'package:aussie/util/social_media_platform.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class MainScreenDetailsModel extends Equatable {
  final Map<SocialMediaPlatform, String> socialMediaPlatforms;
  final Map<String, String> descriptions;

  final List<String> imageLinks;
  final String title;

  const MainScreenDetailsModel({
    this.socialMediaPlatforms,
    this.descriptions,
    this.imageLinks,
    this.title,
  });
  @override
  List<Object> get props => [
        socialMediaPlatforms,
        descriptions,
        imageLinks,
        title,
      ];
}
