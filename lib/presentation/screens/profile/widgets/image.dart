import 'package:aussie/providers/providers.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreenImage extends ConsumerWidget {
  const ProfileScreenImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider);
    return SizedBox(
      height: 100,
      width: 100,
      child: buildImage(
        user.mapOrNull(signedIn: (value) => value.profilePictureLink),
        fit: BoxFit.cover,
      ),
    );
  }
}
