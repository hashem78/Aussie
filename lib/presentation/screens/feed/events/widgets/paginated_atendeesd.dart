import 'package:aussie/models/event/event.dart';
import 'package:aussie/presentation/screens/feed/widgets/card_owner.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaginatedAtendees extends StatelessWidget {
  const PaginatedAtendees({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaginateRefreshedChangeListener refreshChangeListener =
        PaginateRefreshedChangeListener();
    EventModel e = getEventModel(context);

    return RefreshIndicator(
      onRefresh: () async {
        refreshChangeListener.refreshed = true;
      },
      child: PaginateFirestore(
        initialLoader: getIndicator(context),
        header: Container(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "Attendents",
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
}
