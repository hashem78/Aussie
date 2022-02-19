import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowUserButton extends ConsumerWidget {
  const FollowUserButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocBuilder<FollowersCubit, FollowersState>(
      buildWhen: (FollowersState previous, FollowersState current) {
        return current is! FollowersWorking;
      },
      builder: (BuildContext context, FollowersState state) {
        bool isBeingFollowed = false;

        if (state is FollowedUser || state is FollowingUser) {
          isBeingFollowed = true;
        } else if (state is UnFollowedUser || state is NotFollowingUser) {
          isBeingFollowed = false;
        }
        return ElevatedButton(
          onPressed: state is! FollowersWorking
              ? isBeingFollowed
                  ? () {
                      final uid = ref
                          .read(scopedUserProvider)
                          .mapOrNull(signedIn: (val) => val.uid);
                      BlocProvider.of<FollowersCubit>(context)
                          .unFollowUser(uid!);
                    }
                  : () {
                      final uid = ref
                          .read(scopedUserProvider)
                          .mapOrNull(signedIn: (val) => val.uid);
                      BlocProvider.of<FollowersCubit>(context).followUser(uid!);
                    }
              : null,
          child: Row(
            children: <Widget>[
              BlocBuilder<FollowersCubit, FollowersState>(
                builder: (BuildContext context, FollowersState state) {
                  if (state is FollowersWorking) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      height: 30,
                      width: 30,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.amber,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              Text(isBeingFollowed ? 'unfollow' : 'follow'),
            ],
          ),
        );
      },
    );
  }
}
