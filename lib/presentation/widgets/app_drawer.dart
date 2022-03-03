import 'package:evento/presentation/screens/profile/profile.dart';
import 'package:evento/presentation/screens/screen_data.dart';
import 'package:evento/state/user_management.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:evento/util/functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

class AussieAppDrawer extends StatelessWidget {
  const AussieAppDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Column(
        children: const [
          DrawerHeader(),
          Spacer(),
          DrawerItem(
            title: ScreenData.settingsTitle,
            iconData: Icons.settings,
            navPath: ScreenData.settingsNavPath,
          ),
        ],
      ),
    );
  }
}

class DrawerHeader extends ConsumerWidget {
  const DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider);
    final pfp = user.mapOrNull(
      signedIn: (value) => value.profilePictureLink,
    )!;
    final heroTag = const Uuid().v4();

    return SafeArea(
      child: Material(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return ProviderScope(
                    overrides: [
                      scopedUserProvider.overrideWithValue(user),
                    ],
                    child: UserProfileScreen(
                      heroTag: heroTag,
                    ),
                  );
                },
              ),
            );
          },
          child: IntrinsicHeight(
            child: Container(
              width: 1.sw,
              margin: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: pfp,
                    imageBuilder: (context, imageProvider) {
                      return Hero(
                        tag: heroTag,
                        child: Container(
                          width: 80,
                          height: 80,
                          alignment: Alignment.centerLeft,
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
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  Text(
                    user.mapOrNull(signedIn: (value) => value.username)!,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 130.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user.mapOrNull(signedIn: (value) => value.email)!,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 75.sp,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.title,
    required this.iconData,
    required this.navPath,
  }) : super(key: key);
  final String title;
  final IconData iconData;
  final String navPath;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(navPath);
      },
      leading: Icon(iconData),
      title: Text(
        getTranslation(context, title),
      ),
    );
  }
}
