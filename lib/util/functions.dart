import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Color getRandomColor() {
  var _col = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  if (_col == Colors.amber) return Colors.lightBlue;

  return _col.shade700;
}

Widget buildImage(
  String imageUrl, {
  BoxFit fit = BoxFit.fill,
  bool showPlaceHolder = true,
  Duration fadeInDuration = const Duration(milliseconds: 500),
}) {
  if (imageUrl.contains(".svg")) {
    return SvgPicture.network(
      imageUrl,
      fit: fit,
    );
  } else if (imageUrl.isNotEmpty) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      fadeInDuration: fadeInDuration,
      placeholder: showPlaceHolder
          ? (context, url) => Container(
                color: Colors.lightBlueAccent,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
          : null,
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  } else {
    return null;
  }
}
