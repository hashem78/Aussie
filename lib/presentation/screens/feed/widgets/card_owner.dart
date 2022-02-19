import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardOwner extends ConsumerWidget {
  const CardOwner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    

    final user = ref.watch(scopedUserProvider);
    final pfp = user.mapOrNull(signedIn: (value) => value.profilePictureLink);
    final uname = user.mapOrNull(signedIn: (value) => value.username);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return ProviderScope(
                  overrides: [scopedUserProvider.overrideWithValue(user)],
                  child: const UserProfileScreen(),
                );
              },
            ),
          );
        },
        child: SizedBox(
          height: 50,
          child: Row(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: pfp!,
                imageBuilder: (
                  BuildContext context,
                  ImageProvider<Object> imageProvider,
                ) {
                  return SizedBox(
                    width: 50,
                    child: Ink.image(image: imageProvider),
                  );
                },
              ),
              SizedBox(width: .05.sw),
              Text(
                uname!,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
