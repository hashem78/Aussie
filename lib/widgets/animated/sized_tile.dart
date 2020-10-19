import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/widgets/sized_tile.dart';

class AnimatedSizedTile extends StatefulWidget {
  final String title;
  final int widthFactor;
  final int heightFactor;
  final SizedTile sizeTile;
  final Widget child;
  final Widget image;
  final Color swatchColor;
  final int swatchMaxLines;
  AnimatedSizedTile({
    Key key,
    @required this.title,
    this.widthFactor,
    this.heightFactor,
    @required this.image,
    this.swatchColor,
    this.swatchMaxLines,
  })  : child = null,
        sizeTile = SizedTile(
          title: title,
          image: image,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          swatchColor: swatchColor,
          swatchMaxLines: swatchMaxLines,
        );
  AnimatedSizedTile.withDetails({
    @required this.title,
    @required this.image,
    this.widthFactor,
    this.heightFactor,
    @required this.child,
    this.swatchColor,
    this.swatchMaxLines,
  }) : sizeTile = SizedTile.withDetails(
          title: title,
          image: image,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: child,
          swatchColor: swatchColor,
          swatchMaxLines: swatchMaxLines,
        );
  @override
  _AnimatedSizedTileState createState() => _AnimatedSizedTileState();
}

class _AnimatedSizedTileState extends State<AnimatedSizedTile>
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
