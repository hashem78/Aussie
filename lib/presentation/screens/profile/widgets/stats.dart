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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              "${user.numberOfPosts} ${getTranslation(context, 'userProfileStatsPosts')}"),
          Text(
              "${user.numberOfFollowers} ${getTranslation(context, 'userProfileStatsFollowers')}"),
          Text(
              "${user.numberOfFollowing} ${getTranslation(context, 'userProfileStatsFollowing')}"),
        ],
      ),
    );
  }
}
