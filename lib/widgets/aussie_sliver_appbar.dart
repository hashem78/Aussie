import 'package:flutter/material.dart';

import 'package:Aussie/constants.dart';

class AussieSliverAppBar extends StatelessWidget {
  final String title;
  final bool showHero;
  final bool automaticallyImplyLeading;
  final Color backgroundColor;
  const AussieSliverAppBar({
    @required this.title,
    @required this.showHero,
    this.backgroundColor = kausBlue,
    this.automaticallyImplyLeading = true,
  }) : assert(showHero != null && title != null);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 70,
      pinned: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(title),
        centerTitle: true,
      ),
      actions: [
        if (showHero)
          Hero(
            tag: "auFlag",
            child: Image.asset('assests/images/au.png'),
          ),
      ],
    );
  }
}
