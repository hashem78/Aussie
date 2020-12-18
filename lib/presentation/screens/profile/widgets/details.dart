import 'package:aussie/models/usermanagement/user/user.dart';
import 'package:aussie/util/functions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreenCardDetails extends StatelessWidget {
  const ProfileScreenCardDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AussieUser user = getCurrentUser(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: .6.sw,
          child: AutoSizeText(
            user.fullname,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        AutoSizeText(
          user.username,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
