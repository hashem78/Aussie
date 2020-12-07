import 'dart:async';
import 'dart:math';

import 'package:aussie/util/pair.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedCardImage extends StatelessWidget {
  const FeedCardImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _image = _getImage("https://picsum.photos/1500/1000");
    return FutureBuilder<Size>(
      future: _image.second,
      builder: (context, snapshot) {
        Widget child;
        if (!snapshot.hasData)
          child = Container(
            key: ValueKey(0),
            height: .4.sh,
            width: 1.sw,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        else if (snapshot.data == null)
          child = Container(
            key: ValueKey(1),
            width: .2.sw,
            height: .3.sh,
            color: Colors.red,
          );
        else
          child = Container(
            key: ValueKey(2),
            width: min(1.sw, snapshot.data.width),
            height: min(.4.sh, snapshot.data.height),
            child: _image.first,
          );

        return Padding(
          padding: EdgeInsets.only(top: .02.sh),
          child: Center(
            child: AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: child,
            ),
          ),
        );
      },
    );
  }

  Pair<Ink, Future<Size>> _getImage(String url) {
    Completer<Size> completer = Completer();

    ImageProvider image = CachedNetworkImageProvider(url);

    image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return Pair(
        Ink.image(
          image: image,
          fit: BoxFit.cover,
        ),
        completer.future);
  }
}
