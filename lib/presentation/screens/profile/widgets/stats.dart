import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/providers.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreenCardStats extends ConsumerWidget {
  const ProfileScreenCardStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider);
    String postsString = getTranslation(context, 'userProfileStatsPosts');
    final noPosts = user.mapOrNull(signedIn: (value) => value.numberOfPosts)!;
    if (noPosts == 1) {
      postsString = postsString.substring(
        0,
        postsString.length - 1,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            '$noPosts $postsString',
          ),
          const UserFollowersButton(),
          const UserFollowingButton(),
        ],
      ),
    );
  }
}
