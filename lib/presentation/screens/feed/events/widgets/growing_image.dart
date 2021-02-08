import 'package:aussie/models/event_image/event_image.dart';
import 'package:aussie/presentation/widgets/aussie/aussie_photo_view.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';

import 'package:aussie/util/functions.dart';

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
      duration: const Duration(seconds: 3),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            controller.animateBack(0, duration: const Duration(seconds: 3));
          } else {
            if (status == AnimationStatus.dismissed) controller.forward();
          }
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
      onTap: () {
        Navigator.of(context).push(
          PageTransition(
            child: AussiePhotoView(
              url: Provider.of<EventImageModel>(context, listen: false)
                  .imageLink,
            ),
            type: PageTransitionType.fade,
          ),
        );
      },
      onLongPressStart: (_) {
        controller.forward();
      },
      onLongPressEnd: (details) {
        controller.reset();
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
            Provider.of<EventImageModel>(context, listen: false).imageLink,
            fit: BoxFit.fitHeight),
      ),
    );
  }
}
