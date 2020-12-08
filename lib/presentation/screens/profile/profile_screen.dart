import 'package:aussie/presentation/screens/profile/widgets/banner.dart';
import 'package:aussie/presentation/screens/profile/widgets/card_stack.dart';
import 'package:aussie/presentation/screens/profile/widgets/events.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: .4.sh,
            //collapsedHeight: .4.sh,
            pinned: true,
            flexibleSpace: Stack(
              overflow: Overflow.visible,
              children: [
                BannerImage(
                  colorFilter: ColorFilter.mode(
                    Colors.white.withAlpha(70),
                    BlendMode.lighten,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: -.1.sh,
                  child: ProfileCardStack(),
                ),
              ],
            ),
          ),
          ProfileEvents(),
        ],
      ),
    );
  }
}
