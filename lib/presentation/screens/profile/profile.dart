import 'package:aussie/aussie_imports.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserManagementCubit, UserManagementState>(
        builder: (context, state) {
          if (state is UserMangementHasUserData) {
            return Provider.value(
              value: state.user,
              child: CustomScrollView(
                slivers: [
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
                  const SliverToBoxAdapter(child: ProfileCard()),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
