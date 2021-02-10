import 'package:aussie/models/event/event_model.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCardDetailsHeader extends StatelessWidget {
  const EventCardDetailsHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventModel e = getEventModel(context);

    final DateTime begin =
        DateTime.fromMillisecondsSinceEpoch(e.startingTimeStamp);
    final DateTime end = DateTime.fromMillisecondsSinceEpoch(e.endingTimeStamp);
    final formattedBeginDate = DateFormat("dd/MM/yyyy").format(begin);
    final formattedEndDate = DateFormat("dd/MM/yyyy").format(end);
    final formattedBeginTime = DateFormat("hh:mm:ss").format(begin);
    final formattedEndTime = DateFormat("hh:mm:ss").format(end);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Starts on $formattedBeginDate",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.green),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                "at $formattedBeginTime",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Ends on $formattedEndDate",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.red),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Text(
                "at $formattedEndTime",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
