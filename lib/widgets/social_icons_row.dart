import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:Aussie/util/pair.dart';
import 'package:Aussie/util/social_media_platform.dart';
import 'package:Aussie/widgets/animated/social_icon.dart';

class SocialsIconRow extends StatelessWidget {
  /// A list of a tuple of strings.
  /// The tuples represent the desired social media icon and the link to the profile of it's owner
  final List<Pair<SocialMediaPlatform, String>> icons;
  static final Map<SocialMediaPlatform, Pair<IconData, Color>> _internalMap = {
    SocialMediaPlatform.facebook: Pair(FontAwesomeIcons.facebook, Colors.white),
    SocialMediaPlatform.twitter: Pair(FontAwesomeIcons.twitter, Colors.blue),
    SocialMediaPlatform.twitch: Pair(FontAwesomeIcons.twitch, Colors.blue),
    SocialMediaPlatform.instagram:
        Pair(FontAwesomeIcons.instagram, Colors.amber),
    SocialMediaPlatform.snapchat:
        Pair(FontAwesomeIcons.snapchat, Colors.yellow),
    SocialMediaPlatform.youtube: Pair(FontAwesomeIcons.youtube, Colors.red),
    SocialMediaPlatform.tiktok: Pair(FontAwesomeIcons.tiktok, Colors.black),
    SocialMediaPlatform.googleMaps:
        Pair(FontAwesomeIcons.mapMarked, Colors.amber),
    SocialMediaPlatform.pintrest: Pair(FontAwesomeIcons.pinterest, Colors.green)
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
