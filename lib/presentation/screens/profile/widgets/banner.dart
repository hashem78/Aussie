import 'package:flutter/material.dart';

import 'package:aussie/util/functions.dart';

class BannerImage extends StatelessWidget {
  final ColorFilter colorFilter;
  const BannerImage({
    Key key,
    this.colorFilter,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return buildImage(
      "https://picsum.photos/400",
      fit: BoxFit.cover,
      colorFilter: colorFilter,
    );
  }
}
