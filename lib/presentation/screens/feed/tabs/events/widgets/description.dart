import 'package:aussie/models/event/event.dart';
import 'package:aussie/util/functions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class EventCardDescription extends StatelessWidget {
  const EventCardDescription({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventModel e = getEventModel(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            e.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          AutoSizeText(
            e.address,
            style: Theme.of(context).textTheme.overline,
          ),
        ],
      ),
    );
  }
}
