import 'package:aussie/presentation/screens/profile/widgets/image.dart';
import 'package:aussie/state/user_management.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreenAppBar extends ConsumerWidget {
  const ProfileScreenAppBar({
    Key? key,
    required this.heroTag,
  }) : super(key: key);

  final String heroTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider).mapOrNull(
          signedIn: (val) => val,
        )!;

    final banner = user.profileBannerLink;
    return SliverAppBar(
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
            child: ProfileScreenImage(
              heroTag: heroTag,
            ),
          ),
        ],
      ),
    );
  }
}
