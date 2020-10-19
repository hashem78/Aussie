import 'package:flutter/material.dart';

import '../../size_config.dart';

class AnimatedBannerImage extends StatelessWidget {
  final Widget image;
  final double heightFactor;
  final String heroTag;
  const AnimatedBannerImage({
    Key key,
    @required this.image,
    this.heightFactor = 1 / 3,
    @required this.heroTag,
  }) : assert(
          heightFactor != null && image != null,
          "An animated banner Image has either it's image, heightFactor or heroTag properties set to null",
        );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.all(10),
      height: SizeConfig.blockSizeVertical * heightFactor,
      child: Hero(
        tag: heroTag,
        child: image,
      ),
    );
  }
}
