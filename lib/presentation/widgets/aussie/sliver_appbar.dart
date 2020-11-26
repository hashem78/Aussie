import 'package:aussie/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AussieSliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: .29.sh,
      collapsedHeight: .29.sh,
      elevation: 10,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            stretchModes: [
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
          ),
          Positioned.fill(
            child: Container(
              color: kausBlue,
              child: SvgPicture.asset(
                'assests/images/au.svg',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "Aussie",
              style: TextStyle(
                fontSize: 100.sp,
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
