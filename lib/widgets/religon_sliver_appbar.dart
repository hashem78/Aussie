import 'package:flutter/material.dart';

class ReligonSliverAppBar extends StatelessWidget {
  final String title;

  const ReligonSliverAppBar({
    @required this.title,
  }) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      title: Text(title),
    );
  }
}
