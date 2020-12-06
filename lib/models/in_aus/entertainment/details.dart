import 'package:aussie/interfaces/genres.dart';
import 'package:aussie/interfaces/ratings.dart';
import 'package:aussie/models/in_aus/main_screen_details.dart';

import 'package:aussie/presentation/widgets/ratings/ratings_section.dart';
import 'package:aussie/util/functions.dart';
import 'package:aussie/util/social_media_platform.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class EntertainmentDetailsModel extends MainScreenDetailsModel
    implements RatingsInterface, IGenres {
  final List<String> genres;
  final String id;

  const EntertainmentDetailsModel({
    @required String title,
    this.id,
    Map<SocialMediaPlatform, String> socialMediaPlatforms,
    Map<String, String> descriptions,
    this.genres,
    List<String> imageLinks,
  }) : super(
          title: title,
          socialMediaPlatforms: socialMediaPlatforms,
          descriptions: descriptions,
          imageLinks: imageLinks,
        );

  @override
  Widget buildRatings(BuildContext context) => RatingsSection(
        id: id,
        ratingsRoute: ratingsRoute,
        imageLinks: imageLinks,
        colorData: getCurrentThemeModel(context).entertainmentScreenColor,
      );

  @override
  Widget buildGenres() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text("Genres: ", style: TextStyle(fontSize: 50.sp)),
            Text(genres.reduce((value, element) => '$value, $element')),
          ],
        ),
      );
  factory EntertainmentDetailsModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    var _platforms = Map<String, String>.from(map['socialMediaPlatforms'])
        .map<SocialMediaPlatform, String>(
      (key, value) => MapEntry<SocialMediaPlatform, String>(
        key.toSocialMediaPlatform(),
        value,
      ),
    );
    var _model = EntertainmentDetailsModel(
      title: map["title"].toString(),
      id: map["id"].toString(),
      socialMediaPlatforms: _platforms,
      genres: List<String>.from(map['geners']),
      descriptions: Map<String, String>.from(map["descriptions"]),
      imageLinks: List<String>.from(map['imageLinks']),
    );
    return _model;
  }

  @override
  bool get stringify => true;

  @override
  String get ratingsRoute => "entertainment_reviews";
}
