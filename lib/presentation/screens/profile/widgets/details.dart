import 'package:aussie/state/user_management.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreenCardDetails extends ConsumerWidget {
  const ProfileScreenCardDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AutoSizeText(
          user.mapOrNull(signedIn: (value) => value.fullname)!,
          maxLines: 1,
          style: Theme.of(context).textTheme.headline5,
        ),
        AutoSizeText(
          user.mapOrNull(signedIn: (value) => value.username)!,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
