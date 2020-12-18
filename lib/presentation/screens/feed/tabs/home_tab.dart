import 'package:aussie/models/event/event.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/card.dart';
import 'package:aussie/state/eventmanagement/cubit/eventmanagement_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class HomeEventsTab extends StatefulWidget {
  @override
  _HomeEventsTabState createState() => _HomeEventsTabState();
}

class _HomeEventsTabState extends State<HomeEventsTab>
    with AutomaticKeepAliveClientMixin {
  PagingController<int, EventModel> _controller =
      PagingController<int, EventModel>(firstPageKey: 0);

  EventManagementCubit cubit;

  @override
  void initState() {
    super.initState();

    _controller.addPageRequestListener(
      (pageKey) {
        if (cubit.prevSnap == null) {
          cubit.fetchUserEvents();
        } else {
          cubit.fetchUserEvents(lastdoc: cubit.prevSnap);
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    cubit = BlocProvider.of<EventManagementCubit>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<EventManagementCubit, EventManagementState>(
      cubit: cubit,
      listener: (context, state) {
        if (state is EventManagementEventsFetched) {
          _controller.appendPage(
            state.models,
            _controller.nextPageKey + state.models.length,
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
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) {
              return Provider.value(
                value: item,
                child: Builder(
                  builder: (context) {
                    return EventCard();
                  },
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
