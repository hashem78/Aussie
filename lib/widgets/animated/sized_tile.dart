import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/screens/details.dart';
import 'package:Aussie/widgets/sized_tile.dart';

class AnimatedSizedImageTile extends StatefulWidget {
  final String title;
  final int widthFactor;
  final int heightFactor;
  final SizedTile sizeTile;
  final Details detailsScreen;
  final CachedNetworkImage image;
  final Color swatchColor;

  AnimatedSizedImageTile({
    Key key,
    @required this.title,
    this.widthFactor,
    this.heightFactor,
    @required this.image,
    this.swatchColor,
  })  : detailsScreen = null,
        sizeTile = SizedTile(
          title: title,
          image: image,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          swatchColor: swatchColor,
        );
  AnimatedSizedImageTile.withDetails({
    @required this.title,
    @required this.image,
    this.widthFactor,
    this.heightFactor,
    @required this.detailsScreen,
    this.swatchColor,
  }) : sizeTile = SizedTile.withDetails(
          title: title,
          image: image,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: detailsScreen,
          swatchColor: swatchColor,
        );
  @override
  _AnimatedSizedTileState createState() => _AnimatedSizedTileState();
}

class _AnimatedSizedTileState extends State<AnimatedSizedImageTile>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Animation<Offset> animation;
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100 + 100 * Random().nextInt(5)),
    )..forward();
    animation = Tween<Offset>(begin: Offset(-.5, 0), end: Offset.zero)
        .animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SlideTransition(
      position: animation,
      child: widget.sizeTile,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
