import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider);
    final isLoggedInUser = FirebaseAuth.instance.currentUser!.uid ==
        user.mapOrNull(signedIn: (value) => value.uid)!;
    return Scaffold(
      floatingActionButton: isLoggedInUser ? const AnimatedAddEventFAB() : null,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: .4.sh,
            pinned: true,
            flexibleSpace: BannerImage(
              profileBannerLink:
                  user.mapOrNull(signedIn: (value) => value.profileBannerLink),
              colorFilter: ColorFilter.mode(
                Colors.white.withAlpha(70),
                BlendMode.lighten,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ProfileCard(
              allowFollowing: !isLoggedInUser,
            ),
          ),
          const SliverToBoxAdapter(
            child: UserFeed(),
          ),
        ],
      ),
    );
  }
}
