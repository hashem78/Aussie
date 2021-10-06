import 'package:aussie/aussie_imports.dart';

class PublicEventsTab extends StatefulWidget {
  const PublicEventsTab({Key? key}) : super(key: key);

  @override
  _PublicEventsTabState createState() => _PublicEventsTabState();
}

class _PublicEventsTabState extends State<PublicEventsTab>
    with AutomaticKeepAliveClientMixin {
  final PagingController<int, EventModel> _controller =
      PagingController<int, EventModel>(firstPageKey: 0);
  late EventManagementCubit cubit;
  @override
  void initState() {
    super.initState();

    _controller.addPageRequestListener(
      (int pageKey) {
        if (cubit.prevSnap == null) {
          cubit.fetchPublicEvents();
        } else {
          cubit.fetchPublicEvents(lastdoc: cubit.prevSnap);
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    cubit = context.read<EventManagementCubit>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<EventManagementCubit, EventManagementState>(
      listener: (BuildContext context, EventManagementState state) {
        if (state is EventManagementEventsFetched) {
          _controller.appendPage(
            state.models,
            _controller.nextPageKey! + state.models.length,
          );
        } else if (state is EventManagementEndEventsFetched) {
          _controller.appendLastPage(state.models);
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          cubit.refresh();
          _controller.refresh();
        },
        child: PagedListView<int, EventModel>(
          pagingController: _controller,
          builderDelegate: PagedChildBuilderDelegate<EventModel>(
            itemBuilder: (BuildContext context, EventModel item, int index) {
              return MultiBlocProvider(
                providers: <BlocProvider<Object?>>[
                  BlocProvider<UserManagementCubit>(
                    create: (BuildContext context) {
                      return UserManagementCubit()
                        ..getUserDataFromUid(
                          item.uid,
                        );
                    },
                  ),
                  BlocProvider<EventManagementCubit>.value(value: cubit)
                ],
                child: Provider<EventModel>.value(
                  value: item,
                  child: const PublicEventCard(),
                ),
              );
            },
            noItemsFoundIndicatorBuilder: (BuildContext context) {
              return Center(
                child: Text(
                  getTranslation(context, 'eventsNoPublic'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
