import 'dart:math';

import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

class GrowingImage extends StatefulWidget {
  @override
  _GrowingImageState createState() => _GrowingImageState();
}

class _GrowingImageState extends State<GrowingImage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed)
            controller..animateBack(0, duration: Duration(seconds: 3));
          else if (status == AnimationStatus.dismissed) controller..forward();
        },
      );
    animation = Tween<double>(begin: 1, end: 2).animate(controller);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) {
        controller..forward();
      },
      onPanCancel: () {
        controller..reset();
        controller.stop();
      },
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: buildImage(
          "https://picsum.photos/${1000 + Random().nextInt(100)}",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
