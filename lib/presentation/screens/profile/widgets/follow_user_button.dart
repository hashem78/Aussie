import 'package:aussie/models/followers_state/followers_state.dart';
import 'package:aussie/models/usermanagement/user/user_model.dart';

import 'package:aussie/repositories/followers_repository.dart';
import 'package:aussie/state/user_management.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FollowingStatusNotifier extends StateNotifier<FollowersState> {
  String uid;
  FollowingStatusNotifier(this.uid)
      : super(const FollowersState.determiningState()) {
    onFirstStart();
  }
  Future<void> onFirstStart() async {
    state = await FollowersRepository.isUserFollowed(uid);
  }

  Future<void> follow() async {
    state = await FollowersRepository.followUser(uid);
  }

  Future<void> unfollow() async {
    state = await FollowersRepository.unFollowUser(uid);
  }
}

final followingStatusProvider = StateNotifierProvider.autoDispose
    .family<FollowingStatusNotifier, FollowersState, AussieUser>(
  (ref, user) {
    final uid = user.mapOrNull(signedIn: (u) => u.uid)!;
    return FollowingStatusNotifier(uid);
  },
);

class FollowUserButton extends ConsumerWidget {
  const FollowUserButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider);
    final followStatus = ref.watch(followingStatusProvider(user));
    return followStatus.when(
      userIsFollowed: () {
        return ElevatedButton(
          onPressed: () {
            ref.read(followingStatusProvider(user).notifier).unfollow();
          },
          child: const Text('unfollow'),
        );
      },
      userIsNotFollowed: () {
        return ElevatedButton(
          onPressed: () {
            ref.read(followingStatusProvider(user).notifier).follow();
          },
          child: const Text('follow'),
        );
      },
      determiningState: () {
        return const ElevatedButton(
          onPressed: null,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: () {
        return const ElevatedButton(
          onPressed: null,
          child: Text('An unknown error occured'),
        );
      },
    );
  }
}
