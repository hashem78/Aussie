import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FollowersType { follwers, following }

class PaginatedFollowers extends ConsumerStatefulWidget {
  const PaginatedFollowers({
    Key? key,
    required this.followersType,
  }) : super(key: key);
  final FollowersType followersType;

  @override
  _PaginatedFollowersState createState() => _PaginatedFollowersState();
}

class _PaginatedFollowersState extends ConsumerState<PaginatedFollowers>
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
        final user = ref.read(scopedUserProvider);
        final uid = user.mapOrNull(signedIn: (value) => value.uid)!;
        if (widget.followersType == FollowersType.follwers) {
          context.read<FollowersCubit>().getFollowersForUser(uid);
        } else {
          context.read<FollowersCubit>().getFollowingForUser(uid);
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
                  itemBuilder: (context, user, index) {
                    return ProviderScope(overrides: [
                      scopedUserProvider.overrideWithValue(user),
                    ], child: const CardOwner());
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
