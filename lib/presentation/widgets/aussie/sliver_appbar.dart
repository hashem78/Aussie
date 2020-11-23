import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AussieSliverAppBar extends StatelessWidget {
  final String title;

  const AussieSliverAppBar({
    @required this.title,
  }) : assert(title != null);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: .31.sh,
      title: Text("Aussie"),
    );
  }
}
