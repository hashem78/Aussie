import 'package:aussie/models/usermanagement/user/user.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreenCardStats extends StatelessWidget {
  const ProfileScreenCardStats({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AussieUser user = getCurrentUser(context);
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(10),
      height: 50,
      child: Row(
        children: [
          Expanded(child: Text("${user.numberOfPosts} posts")),
          Expanded(child: Text("${user.numberOfFollowers} followers")),
          Expanded(child: Text("${user.numberOfFollowing} following")),
        ],
      ),
    );
  }
}
