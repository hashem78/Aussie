import 'package:aussie/interfaces/geners.dart';
import 'package:aussie/interfaces/ratings.dart';
import 'package:aussie/models/gallery.dart';
import 'package:aussie/models/main_screen/main_screen_details.dart';
import 'package:aussie/presentation/widgets/rating/rating_section.dart';
import 'package:aussie/util/functions.dart';
import 'package:aussie/util/social_media_platform.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class EntertainmentDetailsModel extends MainScreenDetailsModel
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
  Widget buildRatings(BuildContext context) => RatingSection(
        id: id,
        titleImageUrl: titleImageUrl,
        ratingsBackgroundColor: getCurrentThemeModel(context)
            .entertainmentScreenColor
            .backgroundColor,
      );

  @override
  Widget buildGeners() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text("Geners: ", style: TextStyle(fontSize: 50.sp)),
            Text(geners.reduce((value, element) => '$value, $element')),
          ],
        ),
      );
  factory EntertainmentDetailsModel.fromMap(Map<String, dynamic> map) {
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
    var _model = EntertainmentDetailsModel(
      title: map["title"].toString(),
      titleImageUrl: map["titleImageUrl"].toString(),
      id: map["id"].toString(),
      socialMediaPlatforms: _platforms,
      geners: List<String>.from(map['geners']),
      descriptions: Map<String, String>.from(map["descriptions"]),
      galleryImageLinks: _models,
    );
    return _model;
  }

  @override
  bool get stringify => true;
}
