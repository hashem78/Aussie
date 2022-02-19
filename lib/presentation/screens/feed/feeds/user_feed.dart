import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as pv;

class UserEvents extends ConsumerStatefulWidget {
  const UserEvents({Key? key}) : super(key: key);

  @override
  _UserEventsState createState() => _UserEventsState();
}

class _UserEventsState extends ConsumerState<UserEvents>
    with AutomaticKeepAliveClientMixin {
  final PagingController<int, EventModel> _controller =
      PagingController<int, EventModel>(firstPageKey: 0);

  late EMCubit eventManagementCubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final user = ref.read(scopedUserProvider);
    final uid = user.mapOrNull(signedIn: (value) => value.uid)!;

    eventManagementCubit = BlocProvider.of<EMCubit>(context);
    _controller.addPageRequestListener(
      (int pageKey) {
        if (eventManagementCubit.prevSnap == null) {
          eventManagementCubit.fetchEventsForUser(
            uid: uid,
          );
        } else {
          eventManagementCubit.fetchEventsForUser(
              uid: uid, lastdoc: eventManagementCubit.prevSnap);
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
          itemBuilder: (context, item, index) {
            return pv.Provider<EventModel>.value(
              value: item,
              child: Builder(
                builder: (context) {
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
