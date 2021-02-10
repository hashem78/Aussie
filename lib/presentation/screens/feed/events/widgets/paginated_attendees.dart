import 'package:aussie/models/event/event.dart';
import 'package:aussie/presentation/screens/feed/widgets/card_owner.dart';
import 'package:aussie/state/attendees/cubit/attendees_cubit.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaginatedAtendees extends StatefulWidget {
  const PaginatedAtendees({
    Key key,
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
    pagingController.addPageRequestListener((pageKey) {
      context.read<AttendeesCubit>().fetchAttendees(e.eventId);
    });

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
      listener: (context, state) {
        if (state is AttendeesActual) {
          pagingController.appendPage(
            state.uuids,
            pagingController.nextPageKey + 1,
          );
        } else if (state is AttendeesActualEnd) {
          pagingController.appendLastPage(state.uuids);
        }
      },
      builder: (context, state) {
        if (state is AttendeesInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AttendeesEmpty) {
          return Center(
            child: Column(
              children: [
                Icon(
                  Icons.sentiment_dissatisfied,
                  size: 300.sp,
                ),
                const Text(
                  "There are no attendees at this moment, refresh or try again later",
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
            child: PagedListView(
              pagingController: pagingController,
              builderDelegate: PagedChildBuilderDelegate<String>(
                itemBuilder: (context, item, index) {
                  return BlocProvider(
                    create: (context) =>
                        UserManagementCubit()..getUserDataFromUid(item),
                    child: const CardOwner(),
                  );
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
