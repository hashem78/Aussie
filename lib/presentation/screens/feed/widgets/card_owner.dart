import 'package:evento/presentation/screens/profile/profile.dart';
import 'package:evento/state/user_management.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardOwner extends ConsumerWidget {
  const CardOwner({
    Key? key,
    required this.heroTag,
  }) : super(key: key);
  final String heroTag;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider);
    final pfp = user.mapOrNull(signedIn: (value) => value.profilePictureLink)!;

    final uname = user.mapOrNull(signedIn: (value) => value.username)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return ProviderScope(
                  overrides: [scopedUserProvider.overrideWithValue(user)],
                  child: UserProfileScreen(
                    heroTag: heroTag,
                  ),
                );
              },
            ),
          );
        },
        child: Row(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: pfp,
              imageBuilder: (
                BuildContext context,
                ImageProvider<Object> imageProvider,
              ) {
                return Hero(
                  tag: heroTag,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              },
              placeholder: (context, _) {
                return const SizedBox(width: 40, height: 40);
              },
            ),
            SizedBox(width: .05.sw),
            Text(
              uname,
              style: TextStyle(fontSize: 75.sp),
            ),
          ],
        ),
      ),
    );
  }
}
