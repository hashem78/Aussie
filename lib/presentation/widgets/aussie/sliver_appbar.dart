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
      forceElevated: true,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(bottom: 100),
          ),
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
                      fit: BoxFit.cover,
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
