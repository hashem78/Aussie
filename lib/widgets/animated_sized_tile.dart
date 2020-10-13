import 'dart:math';

import 'package:flutter/material.dart';

import 'package:Aussie/widgets/sized_tile.dart';

class AnimatedSizedImageTile extends StatefulWidget {
  final String imageUrl;
  final String title;
  final int widthFactor;
  final int heightFactor;
  final SizedImageTile sizeTile;
  AnimatedSizedImageTile({
    Key key,
    this.imageUrl,
    this.title,
    this.widthFactor,
    this.heightFactor,
  })  : sizeTile = SizedImageTile(
          title: title,
          imageUrl: imageUrl,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
        ),
        super(key: key);
  @override
  _AnimatedSizedTileState createState() => _AnimatedSizedTileState();
}

class _AnimatedSizedTileState extends State<AnimatedSizedImageTile>
    with TickerProviderStateMixin {
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
}
