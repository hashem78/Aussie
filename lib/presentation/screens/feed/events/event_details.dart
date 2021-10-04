import 'package:aussie/models/event/event_model.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/event_description_card.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/event_details_card_stack.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/event_details_gallery.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/paginated_attendees.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventModel e = getEventModel(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: AspectRatio(
            aspectRatio: 16 / 9,
            child: buildImage(e.bannerImage!.imageLink, fit: BoxFit.fitWidth),
          ),
          title: Text(getTranslation(context, "eventDetailsTitle")!),
          bottom: const TabBar(
            tabs: [
              Icon(Icons.description),
              Icon(Icons.photo_album),
              Icon(Icons.attach_email_rounded),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            EventDetailsMain(),
            EventDetailsGallery(),
            PaginatedAtendees(),
          ],
        ),
      ),
    );
  }
}

class EventDetailsMain extends StatelessWidget {
  const EventDetailsMain({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const EventCardStack(),
          buildTitle(context, getTranslation(context, "description")!),
          const EventDetailsDescriptionCard(),
        ],
      ),
    );
  }

  Padding buildTitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
