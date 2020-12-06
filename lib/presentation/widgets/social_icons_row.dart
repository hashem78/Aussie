import 'package:aussie/brand_icons_icons.dart';
import 'package:flutter/material.dart';

import 'package:aussie/util/pair.dart';
import 'package:aussie/util/social_media_platform.dart';

class SocialsIconRow extends StatelessWidget {
  /// A list of a tuple of strings.
  /// The tuples represent the desired social media icon and the link to the profile of it's owner
  final Map<SocialMediaPlatform, String> icons;
  static final Map<SocialMediaPlatform, Pair<IconData, Color>> internalMap = {
    SocialMediaPlatform.facebook: Pair(BrandIcons.facebook, Colors.white),
    SocialMediaPlatform.twitter: Pair(BrandIcons.twitter, Colors.blue),
    SocialMediaPlatform.twitch: Pair(BrandIcons.twitch, Colors.blue),
    SocialMediaPlatform.instagram: Pair(BrandIcons.instagram, Colors.amber),
    SocialMediaPlatform.snapchat: Pair(BrandIcons.snapchat, Colors.yellow),
    SocialMediaPlatform.youtube: Pair(BrandIcons.youtube, Colors.red),
    SocialMediaPlatform.tiktok: Pair(BrandIcons.tiktok, Colors.black),
    SocialMediaPlatform.googleMaps: Pair(BrandIcons.googlemaps, Colors.amber),
    SocialMediaPlatform.pintrest: Pair(BrandIcons.pinterest, Colors.green),
    SocialMediaPlatform.primeVideo: Pair(BrandIcons.prime, Colors.blue),
    SocialMediaPlatform.netflix: Pair(BrandIcons.netflix, Colors.red),
    SocialMediaPlatform.hulu: Pair(BrandIcons.hulu, Colors.green),
    SocialMediaPlatform.youtubeTV: Pair(BrandIcons.youtubetv, Colors.red),
    SocialMediaPlatform.spotify: Pair(BrandIcons.spotify, Colors.green),
  };
  SocialsIconRow(this.icons);
  @override
  Widget build(BuildContext context) {
    final _listOfIcons = <Widget>[];
    //icons.forEach((key, value) => _listOfIcons.add(_buildIcon(key, value)));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        spacing: 15,
        alignment: WrapAlignment.center,
        children: _listOfIcons,
      ),
    );
  }

  // AnimatedSocialIcon _buildIcon(SocialMediaPlatform platform, String url) =>
  //     AnimatedSocialIcon(
  //       _internalMap[platform].first,
  //       _internalMap[platform].second,
  //       url,
  //     );
}
