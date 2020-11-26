import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AussieSliverAppBar extends StatelessWidget {
  final Color backgroundColor;

  const AussieSliverAppBar(this.backgroundColor);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: kToolbarHeight,
      elevation: 0,
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
              "Aussie",
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
