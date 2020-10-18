import 'package:Aussie/brand_icons_icons.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/util/pair.dart';
import 'package:Aussie/util/social_media_platform.dart';
import 'package:Aussie/widgets/animated/social_icon.dart';

class SocialsIconRow extends StatelessWidget {
  /// A list of a tuple of strings.
  /// The tuples represent the desired social media icon and the link to the profile of it's owner
  final List<Pair<SocialMediaPlatform, String>> icons;
  static final Map<SocialMediaPlatform, Pair<IconData, Color>> _internalMap = {
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
    SocialMediaPlatform.youtubeTV: Pair(BrandIcons.youtubetv, Colors.red)
  };
  SocialsIconRow(this.icons);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      alignment: WrapAlignment.center,
      children:
          icons.map((e) => buildIcon(_internalMap[e.first], e.second)).toList(),
    );
  }

  Widget buildIcon(Pair<IconData, Color> iconData, String url) =>
      AnimatedSocialIcon(iconData.first, iconData.second, url);
}
