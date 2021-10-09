import 'package:aussie/aussie_imports.dart';

class UserFollowingButton extends StatelessWidget {
  const UserFollowingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AussieUser user = getCurrentUser(context);

    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<PaginatedFollowers>(
            builder: (BuildContext context) {
              return BlocProvider<FollowersCubit>(
                create: (BuildContext context) => FollowersCubit(),
                child: Provider<AussieUser>.value(
                  value: user,
                  child: const PaginatedFollowers(
                    followersType: FollowersType.following,
                  ),
                ),
              );
            },
          ),
        );
      },
      child: Text(
        "${user.numberOfFollowing} ${getTranslation(context, 'userProfileStatsFollowing')}",
      ),
    );
  }
}
