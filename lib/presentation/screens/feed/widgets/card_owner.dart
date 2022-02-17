import 'package:aussie/aussie_imports.dart';

class CardOwner extends StatefulWidget {
  const CardOwner({
    Key? key,
  }) : super(key: key);

  @override
  _CardOwnerState createState() => _CardOwnerState();
}

class _CardOwnerState extends State<CardOwner>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: BlocBuilder<UMCubit, UMCState>(
        builder: (BuildContext context, UMCState state) {
          Widget child;
          if (state is UMCHasUserData) {
            child = InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<BlocProvider<Object?>>(
                    builder: (BuildContext context) => MultiBlocProvider(
                      providers: <BlocProvider<Object?>>[
                        BlocProvider<FollowersCubit>(
                          create: (BuildContext context) {
                            return FollowersCubit()..isUserFollowed(state.user);
                          },
                        ),
                        BlocProvider<UMCubit>(
                          create: (BuildContext context) {
                            return UMCubit()
                              ..getUserDataFromUid(
                                state.user.uid,
                              );
                          },
                        )
                      ],
                      child: const UserProfileScreen(),
                    ),
                  ),
                );
              },
              child: SizedBox(
                height: 50,
                child: Row(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: state.user.profilePictureLink,
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
                      state.user.username,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            );
          } else {
            child = const SizedBox(height: 50, width: 50);
          }
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: child,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
