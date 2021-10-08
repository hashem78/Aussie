import 'package:aussie/aussie_imports.dart';

class UserFollowersButton extends StatelessWidget {
  const UserFollowersButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AussieUser user = getCurrentUser(context);

    String followersString =
        getTranslation(context, 'userProfileStatsFollowers');
    if (user.numberOfFollowers == 1) {
      followersString = followersString.substring(
        0,
        followersString.length - 1,
      );
    }
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
                    followersType: FollowersType.follwers,
                  ),
                ),
              );
            },
          ),
        );
      },
      child: Text(
        '${user.numberOfFollowers} $followersString',
      ),
    );
  }
}
