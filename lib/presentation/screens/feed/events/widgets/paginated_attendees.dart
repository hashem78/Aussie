import 'package:aussie/aussie_imports.dart';

class PaginatedAtendees extends StatefulWidget {
  const PaginatedAtendees({
    Key? key,
  }) : super(key: key);

  @override
  _PaginatedAtendeesState createState() => _PaginatedAtendeesState();
}

class _PaginatedAtendeesState extends State<PaginatedAtendees>
    with AutomaticKeepAliveClientMixin {
  final PagingController<int, String> pagingController =
      PagingController<int, String>(firstPageKey: 1);
  @override
  void initState() {
    super.initState();
    context.read<AttendeesCubit>().reset();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final EventModel e = getEventModel(context);
    pagingController.addPageRequestListener(
      (int pageKey) {
        context.read<AttendeesCubit>().fetchAttendees(e.eventId);
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
    return BlocConsumer<AttendeesCubit, AttendeesState>(
      listener: (BuildContext context, AttendeesState state) {
        if (state is AttendeesActual) {
          pagingController.appendPage(
            state.uuids,
            pagingController.nextPageKey! + 1,
          );
        } else if (state is AttendeesActualEnd) {
          pagingController.appendLastPage(state.uuids);
        }
      },
      builder: (BuildContext context, AttendeesState state) {
        if (state is AttendeesInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AttendeesEmpty) {
          return Center(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.sentiment_dissatisfied,
                  size: 300.sp,
                ),
                const Text(
                  'There are no attendees at this moment, refresh or try again later',
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<AttendeesCubit>().reset();
              pagingController.refresh();
            },
            child: PagedListView<int, String>(
              pagingController: pagingController,
              padding: const EdgeInsets.all(16.0),
              builderDelegate: PagedChildBuilderDelegate<String>(
                itemBuilder: (BuildContext context, String item, int index) {
                  return const CardOwner();
                },
              ),
            ),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
