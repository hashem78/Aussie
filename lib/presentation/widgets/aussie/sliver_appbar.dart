import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AussieSliverAppBar extends StatelessWidget {
  final Color backgroundColor;
  final String title;

  const AussieSliverAppBar(
    this.backgroundColor,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: .28.sh,
      elevation: 5,
      stretch: true,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            stretchModes: [
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
          ),
          Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: backgroundColor,
                  child: SvgPicture.asset(
                    'assests/images/au.svg',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 75.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
