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

  late EMCubit eventManagementCubit;
  late AussieUser user;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    user = context.read<AussieUser>();
    eventManagementCubit = BlocProvider.of<EMCubit>(context);
    _controller.addPageRequestListener(
      (int pageKey) {
        if (eventManagementCubit.prevSnap == null) {
          eventManagementCubit.fetchEventsForUser(
            uid: user.uid,
          );
        } else {
          eventManagementCubit.fetchEventsForUser(
              uid: user.uid, lastdoc: eventManagementCubit.prevSnap);
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
    return BlocListener<EMCubit, EMCState>(
      bloc: eventManagementCubit,
      listener: (BuildContext context, EMCState state) {
        if (state is EMCEventsFetched) {
          _controller.appendPage(
            state.models,
            _controller.nextPageKey! + state.models.length,
          );
        } else if (state is EMCEndEventsFetched) {
          _controller.appendLastPage(state.models);
        }
      },
      child: PagedSliverList<int, EventModel>(
        pagingController: _controller,
        builderDelegate: PagedChildBuilderDelegate<EventModel>(
          itemBuilder: (BuildContext context, EventModel item, int index) {
            return Provider<EventModel>.value(
              value: item,
              child: Builder(
                builder: (BuildContext context) {
                  return const EventCard();
                },
              ),
            );
          },
          noItemsFoundIndicatorBuilder: (BuildContext context) {
            return Center(
              child: Text(
                getTranslation(context, 'eventsNoHome'),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
