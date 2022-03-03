import 'package:evento/presentation/screens/profile/widgets/add_event_fab.dart';
import 'package:evento/presentation/screens/profile/widgets/profile_card.dart';
import 'package:evento/presentation/screens/profile/widgets/profile_screen_appbar.dart';
import 'package:evento/presentation/screens/profile/widgets/user_events.dart';
import 'package:evento/state/user_management.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileScreen extends HookConsumerWidget {
  const UserProfileScreen({
    Key? key,
    required this.heroTag,
  }) : super(key: key);

  final String heroTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider).mapOrNull(
          signedIn: (val) => val,
        )!;

    final localUser = ref.watch(localUserProvider).mapOrNull(
          signedIn: (val) => val,
        )!;
    final isLoggedInUser = user == localUser;

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
            ProfileScreenAppBar(
              heroTag: heroTag,
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 0.065.sh, left: 12, right: 12),
              sliver: const ProfileCard(),
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
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              sliver: UserEvents(),
            ),
          ],
        ),
      ),
    );
  }
}
