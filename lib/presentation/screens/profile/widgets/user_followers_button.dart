import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/providers.dart';
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
          MaterialPageRoute<PaginatedFollowers>(
            builder: (BuildContext context) {
              return BlocProvider<FollowersCubit>(
                create: (BuildContext context) => FollowersCubit(),
                child: ProviderScope(
                  overrides: [scopedUserProvider.overrideWithValue(user)],
                  child: const PaginatedFollowers(
                    followersType: FollowersType.follwers,
                  ),
                ),
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
