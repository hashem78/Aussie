import 'package:aussie/aussie_imports.dart';

enum FollowersType { follwers, following }

class PaginatedFollowers extends StatefulWidget {
  const PaginatedFollowers({
    Key? key,
    required this.followersType,
  }) : super(key: key);
  final FollowersType followersType;
  @override
  _PaginatedFollowersState createState() => _PaginatedFollowersState();
}

class _PaginatedFollowersState extends State<PaginatedFollowers>
    with AutomaticKeepAliveClientMixin {
  final PagingController<int, AussieUser> pagingController =
      PagingController<int, AussieUser>(firstPageKey: 1);
  @override
  void initState() {
    super.initState();
    context.read<FollowersCubit>().reset();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    pagingController.addPageRequestListener(
      (int pageKey) {
        final AussieUser user = context.read<AussieUser>();
        if (widget.followersType == FollowersType.follwers) {
          context.read<FollowersCubit>().getFollowersForUser(user.uid!);
        } else {
          context.read<FollowersCubit>().getFollowingForUser(user.uid!);
        }
      },
    );

    pagingController.notifyPageRequestListeners(0);
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.followersType == FollowersType.follwers
              ? 'Followers'
              : 'Following',
        ),
        elevation: 0,
      ),
      body: BlocConsumer<FollowersCubit, FollowersState>(
        listener: (BuildContext context, FollowersState state) {
          print('followers cubit state: $state');

          if (state is FollowersHasUsersList) {
            pagingController.appendPage(
              state.users,
              pagingController.nextPageKey! + 1,
            );
          } else if (state is FollowersHasUsersEndList) {
            pagingController.appendLastPage(state.users);
          }
        },
        builder: (BuildContext context, FollowersState state) {
          if (state is FollowersInitial) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<FollowersCubit>().reset();
                pagingController.refresh();
              },
              child: PagedListView<int, AussieUser>(
                pagingController: pagingController,
                padding: const EdgeInsets.all(16.0),
                builderDelegate: PagedChildBuilderDelegate<AussieUser>(
                  noItemsFoundIndicatorBuilder: (BuildContext context) {
                    return const Center(
                      child: Text('No followers found'),
                    );
                  },
                  itemBuilder:
                      (BuildContext context, AussieUser item, int index) {
                    return BlocProvider<UserManagementCubit>(
                      create: (BuildContext context) {
                        return UserManagementCubit()
                          ..getUserDataFromUid(
                            item.uid!,
                          );
                      },
                      child: const CardOwner(),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
