import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/providers.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserFollowersButton extends ConsumerWidget {
  const UserFollowersButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider);

    String followersString =
        getTranslation(context, 'userProfileStatsFollowers');
    if (user.mapOrNull(signedIn: (value) => value.numberOfFollowers)! == 1) {
      followersString = followersString.substring(
        0,
        followersString.length - 1,
      );
    }
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<FollowerListWidget>(
            builder: (BuildContext context) {
              return ProviderScope(
                overrides: [
                  scopedUserProvider.overrideWithValue(user),
                ],
                child: const FollowerListWidget(FollowersType.follwers),
              );
            },
          ),
        );
      },
      child: Text(
        '${user.mapOrNull(signedIn: (value) => value.numberOfFollowers)!} $followersString',
      ),
    );
  }
}
