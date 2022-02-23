import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/providers.dart';
import 'package:aussie/util/functions.dart';
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
          Divider(),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: 1.sw,
            height: 0.1.sh,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: pfp,
                  imageBuilder: (context, imageProvider) {
                    return Hero(
                      tag: heroTag,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
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
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Text(
                  user.mapOrNull(signedIn: (value) => value.username)!,
                  maxLines: 1,
                  
                  style: TextStyle(
                    fontSize: 150.sp,
                    
                    color: Colors.black.withOpacity(0.5),
                  ),
                )
              ],
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
