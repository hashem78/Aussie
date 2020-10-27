import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Color getRandomColor() {
  var _col = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  if (_col == Colors.amber) return Colors.lightBlue;

  return _col.shade700;
}

Widget buildImage(String imageUrl, {BoxFit fit = BoxFit.fill}) {
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
    placeholder: (context, url) => Container(
      color: Colors.lightBlueAccent,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
