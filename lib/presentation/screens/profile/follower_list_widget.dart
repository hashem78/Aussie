import 'package:aussie/models/usermanagement/user/user_model.dart';
import 'package:aussie/presentation/screens/feed/widgets/card_owner.dart';

import 'package:aussie/repositories/followers_repository.dart';
import 'package:aussie/repositories/user_management_repository.dart';
import 'package:aussie/state/user_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:uuid/uuid.dart';

enum FollowersType { follwers, following }

class FollowerListWidget extends ConsumerWidget {
  final FollowersType type;
  const FollowerListWidget(
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
      body: FirestoreQueryBuilder<String>(
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
                  return const Center(child: CircularProgressIndicator());
                },
              );
            },
          );
        },
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
