import 'package:aussie/models/event/event_model.dart';
import 'package:aussie/util/functions.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';

class EventDetailsDescriptionCard extends StatelessWidget {
  const EventDetailsDescriptionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventModel e = getEventModel(context);

    return Card(
      shape: const RoundedRectangleBorder(),
      margin: EdgeInsets.zero,
      child: ExpandText(
        e.description,
        maxLines: 20,
      ),
    );
  }
}
