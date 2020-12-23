import 'dart:async';

import 'package:aussie/util/functions.dart';
import 'package:aussie/util/pair.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class InkedImage extends StatelessWidget {
  final String url;
  final bool showProgress;
  final Duration duration;
  const InkedImage(
    this.url, {
    this.duration = const Duration(milliseconds: 500),
    this.showProgress = false,
  });
  @override
  Widget build(BuildContext context) {
    final _image = _getImage(url);
    return FutureBuilder<bool>(
      future: _image.second,
      builder: (context, snapshot) {
        Widget child;
        if (!snapshot.hasData && showProgress) {
          child = Container(
            key: const ValueKey(0),
            child: Center(
              child: getIndicator(context),
            ),
          );
        } else if (snapshot.data != null) {
          child = Container(
            key: const ValueKey(1),
            child: _image.first,
          );
        }

        return Center(
          child: AnimatedSwitcher(
            duration: duration,
            child: child,
          ),
        );
      },
    );
  }

  Pair<Ink, Future<bool>> _getImage(String url) {
    final Completer<bool> completer = Completer();

    final ImageProvider image = CachedNetworkImageProvider(url);
    image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((_, __) => completer.complete(true)));
    return Pair(Ink.image(image: image, fit: BoxFit.cover), completer.future);
  }
}