import 'package:aussie/models/event/event.dart';
import 'package:aussie/presentation/screens/feed/widgets/card_owner.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaginatedAtendees extends StatefulWidget {
  const PaginatedAtendees({
    Key key,
  }) : super(key: key);

  @override
  _PaginatedAtendeesState createState() => _PaginatedAtendeesState();
}

class _PaginatedAtendeesState extends State<PaginatedAtendees>
    with AutomaticKeepAliveClientMixin {
  final PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();
  @override
  Widget build(BuildContext context) {
    super.build(context);

    EventModel e = getEventModel(context);

    return RefreshIndicator(
      onRefresh: () async {
        print("refresh");
        refreshChangeListener.refreshed = true;
      },
      child: PaginateFirestore(
        initialLoader: Center(child: getIndicator(context)),
        emptyDisplay: Center(
          child: Column(
            children: [
              Icon(
                Icons.sentiment_dissatisfied,
                size: 300.sp,
              ),
              Text(
                "There are no attendees at this moment, refresh or try again later",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        bottomLoader: Center(
          child: LoadingBouncingGrid.square(
            backgroundColor: Colors.blue,
            size: 15,
          ),
        ),
        header: Container(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "Attendees",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          height: .05.sh,
        ),
        itemBuilder: (index, context, snapshot) {
          final data = snapshot.data();
          return BlocProvider(
            create: (context) =>
                UserManagementCubit()..getUserDataFromUid(data["uid"]),
            child: PublicCardOwner(useValue: true),
          );
        },
        listeners: [
          refreshChangeListener,
        ],
        query: FirebaseFirestore.instance
            .collection("event")
            .doc(e.eventId)
            .collection("attendees")
            .orderBy("uid"),
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
