import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AussieSliverAppBar extends StatelessWidget {
  final String title;
  final bool showHero;
  final bool automaticallyImplyLeading;

  final bool pinned;
  const AussieSliverAppBar({
    @required this.title,
    @required this.showHero,
    this.automaticallyImplyLeading = true,
    this.pinned = false,
  }) : assert(showHero != null && title != null);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 60.h,
      pinned: pinned,
      automaticallyImplyLeading: automaticallyImplyLeading,
      flexibleSpace: FlexibleSpaceBar(
        title: AutoSizeText(
          title,
          maxFontSize: 13,
        ),
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
