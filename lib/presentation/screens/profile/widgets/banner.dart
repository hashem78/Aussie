import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

class BannerImage extends StatelessWidget {
  final ColorFilter? colorFilter;
  const BannerImage({
    Key? key,
    this.colorFilter,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final banner = getCurrentUser(context).profileBannerLink;
    return buildImage(
      banner,
      fit: BoxFit.cover,
      colorFilter: colorFilter,
    )!;
  }
}
