import 'package:aussie/models/event/event.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/event_description_card.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/event_details_card_stack.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/event_details_gallery.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/paginated_attendees.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EventModel e = getEventModel(context);
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              flexibleSpace: AspectRatio(
                aspectRatio: 16 / 9,
                child: buildImage(e.bannerImage.imageLink),
              ),
              pinned: true,
              title: Text(getTranslation(context, "eventDetailsTitle")),
              bottom: const TabBar(
                tabs: [
                  Icon(Icons.description),
                  Icon(Icons.attach_email_rounded),
                ],
              ),
            ),
          ],
          body: const TabBarView(
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
        const SliverToBoxAdapter(child: EventCardStack()),
        buildTitle(context, getTranslation(context, "description")),
        const SliverToBoxAdapter(child: EventDetailsDescriptionCard()),
        buildTitle(context, getTranslation(context, "gallery")),
        const SliverToBoxAdapter(child: EventDetailsGallery()),
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
