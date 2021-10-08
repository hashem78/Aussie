import 'package:aussie/aussie_imports.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User fbUser = FirebaseAuth.instance.currentUser!;
    return BlocBuilder<UserManagementCubit, UserManagementState>(
      builder: (BuildContext context, UserManagementState state) {
        bool isLoggedInUser = false;

        if (state is UserMangementHasUserData) {
          isLoggedInUser = state.user.uid == fbUser.uid;
        }
        return Scaffold(
          floatingActionButton:
              isLoggedInUser ? const AnimatedAddEventFAB() : null,
          body: (state is UserMangementHasUserData)
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
                      BlocProvider<EventManagementCubit>(
                        create: (BuildContext context) =>
                            EventManagementCubit(),
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
