import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AussieSliverAppBar extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final double height;
  final BoxFit fit;

  const AussieSliverAppBar(
    this.backgroundColor,
    this.title, {
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      primary: true,
      pinned: true,
      expandedHeight: height,
      collapsedHeight: height,
      flexibleSpace: Stack(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned.fill(
                top: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: backgroundColor,
                    child: SvgPicture.asset(
                      'assests/images/au.svg',
                      fit: fit,
                    ),
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
