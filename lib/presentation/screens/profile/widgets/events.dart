import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

class ProfileEvents extends StatelessWidget {
  const ProfileEvents({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return buildImage("https://picsum.photos/1300");
        },
        childCount: 15,
      ),
    );
  }
}
