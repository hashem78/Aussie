import 'dart:math';

import 'package:Aussie/screens/details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/widgets/sized_tile.dart';

class AnimatedSizedImageTile extends StatefulWidget {
  final String title;
  final int widthFactor;
  final int heightFactor;
  final SizedImageTile sizeTile;
  final Details detailsScreen;
  final CachedNetworkImage image;

  AnimatedSizedImageTile({
    @required this.title,
    @required this.image,
    this.widthFactor,
    this.heightFactor,
  })  : detailsScreen = null,
        sizeTile = SizedImageTile(
          title: title,
          image: image,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
        );
  AnimatedSizedImageTile.withDetails({
    @required this.title,
    @required this.image,
    this.widthFactor,
    this.heightFactor,
    @required this.detailsScreen,
  }) : sizeTile = SizedImageTile.withDetails(
          title: title,
          image: image,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          detailsScreen: detailsScreen,
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
