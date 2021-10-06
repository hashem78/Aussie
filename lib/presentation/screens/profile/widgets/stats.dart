import 'package:aussie/models/usermanagement/user/user_model.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

class ProfileScreenCardStats extends StatelessWidget {
  const ProfileScreenCardStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AussieUser user = getCurrentUser(context);
    String postsString = getTranslation(context, 'userProfileStatsPosts');
    String followersString =
        getTranslation(context, 'userProfileStatsFollowers');
    if (user.numberOfPosts == 1) {
      postsString = postsString.substring(
        0,
        postsString.length - 1,
      );
    }
    if (user.numberOfFollowers == 1) {
      followersString = followersString.substring(
        0,
        followersString.length - 1,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:<Widget> [
          Text(
            '${user.numberOfPosts} $postsString',
          ),
          Text(
            '${user.numberOfFollowers} $followersString',
          ),
          Text(
            "${user.numberOfFollowing} ${getTranslation(context, 'userProfileStatsFollowing')}",
          ),
        ],
      ),
    );
  }
}
