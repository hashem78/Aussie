import 'package:aussie/presentation/screens/profile/follower_list_widget.dart';
import 'package:aussie/state/user_management.dart';

import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserFollowingButton extends ConsumerWidget {
  const UserFollowingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider);

    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProviderScope(
                overrides: [
                  scopedUserProvider.overrideWithValue(user),
                ],
                child: const FollowerListWidget(FollowersType.following),
              );
            },
          ),
        );
      },
      child: Text(
        "${user.mapOrNull(signedIn: (value) => value.numberOfFollowing)} ${getTranslation(context, 'userProfileStatsFollowing')}",
      ),
    );
  }
}
