import 'package:aussie/models/event/event_model.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/card.dart';
import 'package:aussie/presentation/screens/profile/widgets/add_event_fab.dart';
import 'package:aussie/presentation/screens/profile/widgets/image.dart';
import 'package:aussie/presentation/screens/profile/widgets/profile_card.dart';
import 'package:aussie/repositories/event_management_repository.dart';
import 'package:aussie/state/event_management.dart';
import 'package:aussie/state/user_management.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileScreen extends HookConsumerWidget {
  const UserProfileScreen({
    Key? key,
    required this.heroTag,
  }) : super(key: key);

  final String heroTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider);
    final uid = user.mapOrNull(signedIn: (u) => u.uid)!;
    final banner = user.mapOrNull(
      signedIn: (value) => value.profileBannerLink,
    )!;
    final isLoggedInUser = FirebaseAuth.instance.currentUser!.uid ==
        user.mapOrNull(
          signedIn: (value) => value.uid,
        )!;
    final showFAB = useValueNotifier(true);

    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.direction == ScrollDirection.reverse) {
          showFAB.value = false;
        } else {
          showFAB.value = true;
        }
        return true;
      },
      child: Scaffold(
        floatingActionButton: isLoggedInUser && useValueListenable(showFAB)
            ? const AnimatedAddEventFAB()
            : null,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              collapsedHeight: 0.3.sh,
              flexibleSpace: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: 0.3.sh,
                    width: 1.sw,
                    child: CachedNetworkImage(
                      imageUrl: banner,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    bottom: -0.065.sh,
                    right: 0,
                    left: 0,
                    child: ProfileScreenImage(heroTag: heroTag),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 0.065.sh, left: 12, right: 12),
              sliver: SliverToBoxAdapter(
                child: Card(
                  child: ProfileCard(
                    allowFollowing: !isLoggedInUser,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Events',
                  style: TextStyle(
                    fontSize: 150.sp,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: FirestoreQueryBuilder<EventModel>(
                query: EventManagementRepository.fetchEventsForUser(uid),
                builder: (context, snapshot, child) {
                  if (snapshot.hasData && snapshot.docs.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text('There are no events'),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text('error ${snapshot.error}'),
                      ),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (snapshot.hasMore &&
                            index + 1 == snapshot.docs.length) {
                          snapshot.fetchMore();
                        }
                        final event = snapshot.docs[index].data();
                        return ProviderScope(
                          overrides: [
                            scopedEventProvider.overrideWithValue(event)
                          ],
                          child: const EventCard(),
                        );
                      },
                      childCount: snapshot.docs.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
