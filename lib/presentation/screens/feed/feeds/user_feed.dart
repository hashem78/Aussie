import 'package:aussie/aussie_imports.dart';

class UserEvents extends StatefulWidget {
  const UserEvents({Key? key}) : super(key: key);

  @override
  _UserEventsState createState() => _UserEventsState();
}

class _UserEventsState extends State<UserEvents>
    with AutomaticKeepAliveClientMixin {
  final PagingController<int, EventModel> _controller =
      PagingController<int, EventModel>(firstPageKey: 0);

  late EventManagementCubit eventManagementCubit;
  late AussieUser user;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    user = context.read<AussieUser>();
    eventManagementCubit = BlocProvider.of<EventManagementCubit>(context);
    _controller.addPageRequestListener(
      (pageKey) {
        if (eventManagementCubit.prevSnap == null) {
          eventManagementCubit.fetchEventsForUser(
            uid: user.uid!,
          );
        } else {
          eventManagementCubit.fetchEventsForUser(
              uid: user.uid!, lastdoc: eventManagementCubit.prevSnap);
        }
      },
    );

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<EventManagementCubit, EventManagementState>(
      bloc: eventManagementCubit,
      listener: (context, state) {
        if (state is EventManagementEventsFetched) {
          _controller.appendPage(
            state.models,
            _controller.nextPageKey! + state.models.length,
          );
        } else if (state is EventManagementEndEventsFetched) {
          _controller.appendLastPage(state.models);
        }
      },
      child: PagedSliverList<int, EventModel>(
        pagingController: _controller,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, index) {
            return Provider<EventModel>.value(
              value: item,
              child: Builder(
                builder: (context) {
                  return const EventCard();
                },
              ),
            );
          },
          noItemsFoundIndicatorBuilder: (context) {
            return Center(
              child: Text(getTranslation(context, "eventsNoHome")!),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
