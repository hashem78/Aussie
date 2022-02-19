import 'package:aussie/aussie_imports.dart';
import 'package:aussie/models/followers_state/followers_state.dart';
import 'package:aussie/providers/providers.dart';
import 'package:aussie/repositories/followers_repository.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FollowUserButton extends HookConsumerWidget {
  const FollowUserButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider);
    final uid = user.mapOrNull(signedIn: (u) => u.uid)!;
    final isBeingFollowedFuture = useFuture(
      FollowersRepository.isUserFollowed(uid),
    );
    if (isBeingFollowedFuture.hasData) {
      final isBeingFollowed = useValueNotifier(isBeingFollowedFuture.data!);
      return ElevatedButton(
        onPressed: useValueListenable(isBeingFollowed)
            ? () async {
                final state = await FollowersRepository.followUser(uid);
                if (state == const FollowersState.followedUser()) {
                  isBeingFollowed.value = true;
                }
              }
            : () async {
                final state = await FollowersRepository.unFollowUser(uid);
                if (state == const FollowersState.unFollowedUser()) {
                  isBeingFollowed.value = false;
                }
              },
        child: Text(
          useValueListenable(isBeingFollowed) ? 'unfollow' : 'follow',
        ),
      );
    } else {
      return const ElevatedButton(
        onPressed: null,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
