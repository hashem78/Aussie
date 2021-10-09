import 'package:aussie/aussie_imports.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.allowFollowing,
  }) : super(key: key);
  final bool allowFollowing;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              const ProfileScreenImage(),
              const SizedBox(width: 10),
              const Expanded(child: ProfileScreenCardDetails()),
              if (allowFollowing) const FollowUserButton(),
            ],
          ),
          const ProfileScreenCardStats(),
        ],
      ),
    );
  }
}
