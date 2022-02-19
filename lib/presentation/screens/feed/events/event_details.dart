import 'package:aussie/presentation/screens/feed/events/widgets/event_description_card.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/event_details_card_stack.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/event_details_gallery.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/paginated_attendees.dart';
import 'package:aussie/state/event_management.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventDetails extends ConsumerWidget {
  const EventDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final e = ref.watch(scopedEventProvider);
    final bannerImage = e.mapOrNull(remote: (val) => val.bannerImage)!;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: AspectRatio(
            aspectRatio: 16 / 9,
            child: buildImage(bannerImage.imageLink, fit: BoxFit.fitWidth),
          ),
          title: Text(getTranslation(context, 'eventDetailsTitle')),
          bottom: const TabBar(
            tabs: <Icon>[
              Icon(Icons.description),
              Icon(Icons.photo_album),
              Icon(Icons.attach_email_rounded),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
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
        children: <Widget>[
          const EventCardStack(),
          buildTitle(context, getTranslation(context, 'description')),
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
