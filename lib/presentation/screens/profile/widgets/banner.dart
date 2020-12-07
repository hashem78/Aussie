import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

class ProfileBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildImage(
      "https://picsum.photos/400",
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Colors.white.withAlpha(70),
        BlendMode.lighten,
      ),
    );
  }
}
