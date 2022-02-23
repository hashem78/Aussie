import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

class BannerImage extends StatelessWidget {
  final ColorFilter? colorFilter;
  final String? profileBannerLink;
  const BannerImage({
    Key? key,
    this.colorFilter,
    this.profileBannerLink,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return buildImage(
      profileBannerLink,
      fit: BoxFit.fitWidth,
      colorFilter: colorFilter,
    )!;
  }
}
