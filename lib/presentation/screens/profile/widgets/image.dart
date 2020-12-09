import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

class ProfileScreenImage extends StatelessWidget {
  const ProfileScreenImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: buildImage(
        "https://picsum.photos/500",
        fit: BoxFit.cover,
      ),
    );
  }
}