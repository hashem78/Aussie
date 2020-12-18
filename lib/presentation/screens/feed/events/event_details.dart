import 'package:aussie/models/event/event.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/event_description_card.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/event_details_card_stack.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/event_details_gallery.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/paginated_attendees.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                title: Text(getTranslation(context, "eventDetailsTitle")),
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
              EventDetailsMain(),
              PaginatedAtendees(),
            ],
          ),
        ),
      ),
    );
  }
}

class EventDetailsMain extends StatefulWidget {
  const EventDetailsMain({
    Key key,
  }) : super(key: key);

  @override
  _EventDetailsMainState createState() => _EventDetailsMainState();
}

class _EventDetailsMainState extends State<EventDetailsMain>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
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
      ],
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

  @override
  bool get wantKeepAlive => true;
}
