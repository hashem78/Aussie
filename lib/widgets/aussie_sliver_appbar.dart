import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/constants.dart';

class AussieSliverAppBar extends StatelessWidget {
  final String title;
  final bool showHero;
  final bool automaticallyImplyLeading;
  const AussieSliverAppBar({
    @required this.title,
    @required this.showHero,
    this.automaticallyImplyLeading = false,
  }) : assert(showHero != null && title != null);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 70,
      pinned: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: kausBlue,
      flexibleSpace: FlexibleSpaceBar(
        title: AutoSizeText(
          title,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      centerTitle: true,
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
