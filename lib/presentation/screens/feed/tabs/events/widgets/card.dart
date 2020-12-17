import 'package:aussie/models/event/event.dart';
import 'package:aussie/presentation/screens/feed/tabs/events/details.dart';
import 'package:aussie/presentation/screens/feed/tabs/events/widgets/card_details.dart';
import 'package:aussie/presentation/screens/feed/widgets/event_card_image.dart';
import 'package:aussie/presentation/screens/feed/widgets/card_owner.dart';
import 'package:aussie/util/functions.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventCard extends StatefulWidget {
  const EventCard({
    Key key,
  }) : super(key: key);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final EventModel e = getEventModel(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return Provider.value(
                value: e,
                child: Builder(builder: (context) => EventDetails()),
              );
            },
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardOwner(),
              EventCardImage(),
              EventCardDetails(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
