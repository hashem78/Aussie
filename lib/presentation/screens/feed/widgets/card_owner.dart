import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardOwner extends ConsumerWidget {
  const CardOwner({
    Key? key,
    required this.heroTag,
  }) : super(key: key);
  final String heroTag;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider);
    final pfp = user.mapOrNull(signedIn: (value) => value.profilePictureLink)!;

    final uname = user.mapOrNull(signedIn: (value) => value.username)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return ProviderScope(
                  overrides: [scopedUserProvider.overrideWithValue(user)],
                  child: UserProfileScreen(
                    heroTag: heroTag,
                  ),
                );
              },
            ),
          );
        },
        child: Row(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: pfp,
              imageBuilder: (
                BuildContext context,
                ImageProvider<Object> imageProvider,
              ) {
                return Hero(
                  tag: heroTag,
                  child: Container(
                    width: 40,
                    height: 40,
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
            SizedBox(width: .05.sw),
            Text(
              uname,
              style: TextStyle(fontSize: 75.sp),
            ),
          ],
        ),
      ),
    );
  }
}
