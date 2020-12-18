import 'package:aussie/models/event/event.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/event_details_card_stack.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/growing_image.dart';
import 'package:aussie/presentation/screens/feed/widgets/card_owner.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EventModel e = getEventModel(context);
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverSafeArea(
              sliver: SliverAppBar(
                expandedHeight: .6.sh,
                primary: true,
                pinned: true,
                title: Text("Event"),
                flexibleSpace: buildImage(
                  e.bannerImageLink,
                  fit: BoxFit.cover,
                ),
                bottom: TabBar(
                  tabs: [
                    Icon(Icons.description),
                    Icon(Icons.attach_email_rounded),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: [
              CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverToBoxAdapter(
                      child: EventCardStack(),
                    ),
                  ),
                  buildTitle(context, "Description"),
                  SliverToBoxAdapter(child: EventDetailsDescriptionCard()),
                  buildTitle(context, "Gallery"),
                  EventDetailsGallery(),
                  buildTitle(context, "Attending"),
                ],
              ),
              PaginatedAtendees(),
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding buildTitle(BuildContext context, String text) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}

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

class EventDetailsDescriptionCard extends StatelessWidget {
  const EventDetailsDescriptionCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final e = getEventModel(context);

    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpandText(
          e.description,
          textAlign: TextAlign.center,
          expandOnGesture: false,
        ),
      ),
    );
  }
}

class EventDetailsGallery extends StatelessWidget {
  const EventDetailsGallery({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final e = getEventModel(context);

    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverToBoxAdapter(
        child: CarouselSlider(
          items: e.galleryImageLinks
              .map(
                (e) => Provider.value(
                  value: e,
                  child: Builder(builder: (_) => GrowingImage()),
                ),
              )
              .toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            height: .5.sh,
            pageSnapping: true,
            enableInfiniteScroll: false,
            pageViewKey: PageStorageKey<String>("dgal-${e.uid}"),
          ),
        ),
      ),
    );
  }
}
