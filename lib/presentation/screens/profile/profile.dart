import 'package:aussie/aussie_imports.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User fbUser = FirebaseAuth.instance.currentUser!;
    return BlocBuilder<UMCubit, UMCState>(
      builder: (BuildContext context, UMCState state) {
        bool isLoggedInUser = false;

        if (state is UMCHasUserData) {
          isLoggedInUser = state.user.uid == fbUser.uid;
        }
        return Scaffold(
          floatingActionButton:
              isLoggedInUser ? const AnimatedAddEventFAB() : null,
          body: (state is UMCHasUserData)
              ? Provider<AussieUser>.value(
                  value: state.user,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        expandedHeight: .4.sh,
                        //collapsedHeight: .4.sh,
                        pinned: true,
                        flexibleSpace: BannerImage(
                          colorFilter: ColorFilter.mode(
                            Colors.white.withAlpha(70),
                            BlendMode.lighten,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: ProfileCard(
                          allowFollowing: !isLoggedInUser,
                        ),
                      ),
                      BlocProvider<EMCubit>(
                        create: (BuildContext context) =>
                            EMCubit(),
                        child: const UserEvents(),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
