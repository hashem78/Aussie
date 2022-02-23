import 'dart:ui';

import 'package:aussie/presentation/screens/feed/feeds/user_feed.dart';
import 'package:aussie/presentation/screens/profile/widgets/add_event_fab.dart';
import 'package:aussie/presentation/screens/profile/widgets/image.dart';
import 'package:aussie/state/user_management.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String heroTag;
  const UserProfileScreen({
    Key? key,
    required this.heroTag,
  }) : super(key: key);

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  late final ScrollController scrollController;
  final expandedHeight = 0.3.sh;
  final pImageCenterHeight = 0.22.sh;
  double top = 0.22.sh;
  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  double getNextTop() {
    top = pImageCenterHeight;
    if (scrollController.hasClients) {
      final offset = scrollController.offset;

      top = lerpDouble(top, pImageCenterHeight - offset, 1.25)!;
    }
    return top;
  }

  double getPadding() {
    if (scrollController.hasClients) {
      final offset = scrollController.offset;

      return 60 * (1 - offset / expandedHeight);
    }
    return 60;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(scopedUserProvider);
    final banner = user.mapOrNull(
      signedIn: (value) => value.profileBannerLink,
    )!;
    final isLoggedInUser = FirebaseAuth.instance.currentUser!.uid ==
        user.mapOrNull(
          signedIn: (value) => value.uid,
        )!;

    return Scaffold(
      floatingActionButton: isLoggedInUser ? const AnimatedAddEventFAB() : null,
      body: Stack(
        children: [
          NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: expandedHeight,
                  flexibleSpace: FlexibleSpaceBar(
                    background: DecoratedBox(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(banner),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: EdgeInsets.only(
                top: getPadding(),
              ),
              child: const UserFeed(),
            ),
          ),
          Positioned(
            top: getNextTop(),
            right: 0,
            left: 0,
            child: ProfileScreenImage(heroTag: widget.heroTag),
          ),
        ],
      ),
    );
  }
}
