import 'package:aussie/util/functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class ProfileEvents extends StatelessWidget {
  const ProfileEvents({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: .22.sh),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: .4.sw,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: List.filled(
              5,
              Container(
                width: .4.sw,
                margin: EdgeInsets.only(right: 10),
                child: buildImage("https://picsum.photos/seed/picsum/300"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
