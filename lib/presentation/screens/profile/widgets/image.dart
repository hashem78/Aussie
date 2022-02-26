import 'package:evento/state/user_management.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreenImage extends ConsumerWidget {
  const ProfileScreenImage({
    required this.heroTag,
    Key? key,
  }) : super(key: key);
  final String heroTag;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider);
    final pfp = user.mapOrNull(signedIn: (value) => value.profilePictureLink)!;
    return CachedNetworkImage(
      imageUrl: pfp,
      imageBuilder: (context, imageProvider) {
        return Hero(
          tag: heroTag,
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              border:
                  Border.all(width: 4, color: Theme.of(context).canvasColor),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                ),
              ],
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}
