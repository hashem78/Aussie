import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardOwner extends ConsumerStatefulWidget {
  const CardOwner({
    Key? key,
  }) : super(key: key);

  @override
  _CardOwnerState createState() => _CardOwnerState();
}

class _CardOwnerState extends ConsumerState<CardOwner>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final user = ref.watch(scopedUserProvider);
    final pfp = user.mapOrNull(signedIn: (value) => value.profilePictureLink);
    final uname = user.mapOrNull(signedIn: (value) => value.username);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<BlocProvider<Object?>>(
              builder: (BuildContext context) => MultiBlocProvider(
                providers: <BlocProvider<Object?>>[
                  BlocProvider<FollowersCubit>(
                    create: (BuildContext context) {
                      return FollowersCubit()
                        ..isUserFollowed(
                            user.mapOrNull(signedIn: (value) => value.uid)!);
                    },
                  ),
                ],
                child: ProviderScope(
                  overrides: [
                    scopedUserProvider.overrideWithValue(user),
                  ],
                  child: const UserProfileScreen(),
                ),
              ),
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

  @override
  bool get wantKeepAlive => true;
}
