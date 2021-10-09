import 'package:aussie/aussie_imports.dart';

class ProfileScreenCardStats extends StatelessWidget {
  const ProfileScreenCardStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AussieUser user = getCurrentUser(context);
    String postsString = getTranslation(context, 'userProfileStatsPosts');

    if (user.numberOfPosts == 1) {
      postsString = postsString.substring(
        0,
        postsString.length - 1,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            '${user.numberOfPosts} $postsString',
          ),
          const UserFollowersButton(),
          const UserFollowingButton(),
        ],
      ),
    );
  }
}
