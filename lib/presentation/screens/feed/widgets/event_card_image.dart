import 'dart:async';
import 'dart:math';

import 'package:aussie/models/event/event.dart';
import 'package:aussie/util/functions.dart';
import 'package:aussie/util/pair.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EventCardImage extends StatelessWidget {
  const EventCardImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventModel e = Provider.of<EventModel>(context);
    final _image = _getImage(e.bannerImageLink);
    return FutureBuilder<Size>(
      future: _image.second,
      builder: (context, snapshot) {
        Widget child;
        if (!snapshot.hasData) {
          child = SizedBox(
            key: const ValueKey(0),
            height: .4.sh,
            width: 1.sw,
            child: Center(child: getIndicator(context)),
          );
        } else if (snapshot.data == null) {
          child = Container(
            key: const ValueKey(1),
            width: .2.sw,
            height: .3.sh,
            color: Colors.red,
          );
        } else {
          child = SizedBox(
            key: const ValueKey(2),
            width: min(1.sw, snapshot.data.width),
            height: min(.4.sh, snapshot.data.height),
            child: _image.first,
          );
        }

        return Padding(
          padding: EdgeInsets.only(top: .02.sh),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: child,
            ),
          ),
        );
      },
    );
  }

  Pair<Ink, Future<Size>> _getImage(String url) {
    final Completer<Size> completer = Completer();

    final ImageProvider image = CachedNetworkImageProvider(url);

    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          final myImage = image.image;
          final Size size =
              Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return Pair(
      Ink.image(
        image: image,
        fit: BoxFit.cover,
      ),
      completer.future,
    );
  }
}
