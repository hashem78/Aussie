import 'package:evento/models/usermanagement/user/user_model.dart';
import 'package:evento/presentation/screens/feed/widgets/card_owner.dart';

import 'package:evento/repositories/followers_repository.dart';
import 'package:evento/repositories/user_management_repository.dart';
import 'package:evento/state/user_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:uuid/uuid.dart';

enum FollowersType { follwers, following }

class FollowerListScreen extends ConsumerWidget {
  final FollowersType type;
  const FollowerListScreen(
    this.type, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider);
    final uid = user.mapOrNull(signedIn: (u) => u.uid)!;
    return Scaffold(
      appBar: AppBar(
        title: type == FollowersType.follwers
            ? const Text('Followers')
            : const Text('Following'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FirestoreQueryBuilder<String>(
          query: type == FollowersType.follwers
              ? FollowersRepository.getFollowersForUser(uid)
              : FollowersRepository.getFollowingForUser(uid),
          builder: (context, snapshot, _) {
            return ListView.builder(
              itemCount: snapshot.docs.length,
              itemBuilder: (context, index) {
                if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                  snapshot.fetchMore();
                }
                final follower = snapshot.docs[index];
                return FutureBuilder<AussieUser>(
                  future: UMRepository.getUserDataFromUid(follower.data()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ProviderScope(
                        overrides: [
                          scopedUserProvider.overrideWithValue(snapshot.data!)
                        ],
                        child: CardOwner(
                          heroTag: const Uuid().v4(),
                        ),
                      );
                    }
                    return const SizedBox(
                      width: 40,
                      height: 40,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// ProviderScope(
//                       overrides: [
//                         scopedUserProvider.overrideWithValue(user),
//                       ],
//                       child: const CardOwner(),
//                     );
