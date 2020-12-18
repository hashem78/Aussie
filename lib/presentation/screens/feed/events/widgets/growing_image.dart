import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photo_view/photo_view.dart';
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
      onTap: () {
        Navigator.of(context).push(
          PageTransition(
            child: EventGalleryPhotoView(
                url: Provider.of<String>(context, listen: false)),
            type: PageTransitionType.fade,
          ),
        );
      },
      onLongPressStart: (_) {
        controller..forward();
      },
      onLongPressEnd: (details) {
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
          Provider.of<String>(context, listen: false),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class EventGalleryPhotoView extends StatelessWidget {
  final String url;
  const EventGalleryPhotoView({
    Key key,
    this.url,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: BottomAppBar(),
      body: PhotoView(
        minScale: PhotoViewComputedScale.contained,
        maxScale: 1.0,
        imageProvider: CachedNetworkImageProvider(url),
      ),
    );
  }
}
