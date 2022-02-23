import 'package:aussie/aussie_imports.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.allowFollowing,
    required this.heroTag,
  }) : super(key: key);
  final bool allowFollowing;
  final String heroTag;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              ProfileScreenImage(
                heroTag: heroTag,
              ),
              SizedBox(width: 0.1.sw),
              const Expanded(child: ProfileScreenCardDetails()),
              SizedBox(width: 0.1.sw),
              if (allowFollowing) const FollowUserButton(),
            ],
          ),
          const ProfileScreenCardStats(),
        ],
      ),
    );
  }
}
