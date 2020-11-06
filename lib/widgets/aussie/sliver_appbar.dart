import 'package:auto_size_text/auto_size_text.dart';
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
      expandedHeight: .51.sh,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          child: Center(
            child: AutoSizeText(
              title,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 200.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
