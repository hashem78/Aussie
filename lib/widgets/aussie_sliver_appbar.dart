import 'package:flutter/material.dart';

import 'package:Aussie/constants.dart';

class AussieSliverAppBar extends StatelessWidget {
  final String title;
  const AussieSliverAppBar(
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: kausBlue,
      title: Text(title),
      centerTitle: true,
      actions: [
        Hero(
          tag: "auFlag",
          child: Image.asset('assests/images/au.png'),
        ),
      ],
    );
  }
}
