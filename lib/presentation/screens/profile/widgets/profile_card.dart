import 'package:aussie/presentation/screens/profile/widgets/details.dart';
import 'package:aussie/presentation/screens/profile/widgets/follow_user_button.dart';
import 'package:aussie/presentation/screens/profile/widgets/stats.dart';
import 'package:aussie/state/user_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCard extends ConsumerWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider).mapOrNull(
          signedIn: (val) => val,
        )!;
    final localUser = ref.watch(localUserProvider).mapOrNull(
          signedIn: (val) => val,
        )!;
    final isLoggedInUser = user == localUser;
    return SliverToBoxAdapter(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 0.1.sw),
                  const Expanded(child: ProfileScreenCardDetails()),
                  SizedBox(width: 0.1.sw),
                  if (!isLoggedInUser) const FollowUserButton(),
                ],
              ),
              const ProfileScreenCardStats(),
            ],
          ),
        ),
      ),
    );
  }
}
