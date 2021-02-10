import 'package:aussie/models/event/event_model.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/card.dart';
import 'package:aussie/state/eventmanagement/cubit/eventmanagement_cubit.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class PublicEventsTab extends StatefulWidget {
  @override
  _PublicEventsTabState createState() => _PublicEventsTabState();
}

class _PublicEventsTabState extends State<PublicEventsTab>
    with AutomaticKeepAliveClientMixin {
  final PagingController<int, EventModel> _controller =
      PagingController<int, EventModel>(firstPageKey: 0);
  EventManagementCubit cubit;
  @override
  void initState() {
    super.initState();

    _controller.addPageRequestListener(
      (pageKey) {
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
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        UserManagementCubit()..getUserDataFromUid(item.uid),
                  ),
                  BlocProvider.value(value: cubit)
                ],
                child: Provider.value(
                  value: item,
                  child: const PublicEventCard(),
                ),
              );
            },
            noItemsFoundIndicatorBuilder: (context) {
              return Center(
                child: Text(
                  getTranslation(context, "eventsNoPublic"),
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
