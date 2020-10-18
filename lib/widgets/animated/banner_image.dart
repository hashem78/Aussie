import 'package:flutter/material.dart';

import '../../size_config.dart';

class AnimatedBannerImage extends StatefulWidget {
  final Widget image;
  final double heightFactor;
  const AnimatedBannerImage({
    Key key,
    this.image,
    this.heightFactor = 1 / 3,
  }) : super(key: key);
  @override
  _AnimatedBannerImageState createState() => _AnimatedBannerImageState();
}

class _AnimatedBannerImageState extends State<AnimatedBannerImage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..forward();
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(curve: Curves.easeIn, parent: controller),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SizeConfig().init(context);
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        margin: EdgeInsets.all(10),
        height: SizeConfig.blockSizeVertical * widget.heightFactor,
        decoration: BoxDecoration(
            //boxShadow: [BoxShadow(blurRadius: 5)],
            //borderRadius: kaussieRadius,
            ),
        child: widget.image,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
