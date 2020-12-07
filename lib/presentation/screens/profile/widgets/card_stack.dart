import 'package:aussie/presentation/screens/profile/widgets/details.dart';
import 'package:aussie/presentation/screens/profile/widgets/image.dart';
import 'package:aussie/presentation/screens/profile/widgets/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCardStack extends StatelessWidget {
  const ProfileCardStack({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          height: .25.sh,
          width: .9.sw,
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
        Positioned(
          top: -.05.sh,
          left: .04.sw,
          child: ProfileImage(),
        ),
        Positioned(
          top: .02.sh,
          left: .35.sw,
          child: ProfileDetails(),
        ),
        Positioned(
          bottom: .02.sh,
          child: ProfileStats(),
        ),
      ],
    );
  }
}
