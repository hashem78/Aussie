import 'package:evento/state/event_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class EventCardDetailsHeader extends ConsumerWidget {
  const EventCardDetailsHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final e = ref.watch(scopedEventProvider);

    final begin = DateTime.fromMillisecondsSinceEpoch(
      e.startingTimeStamp,
    );
    final end = DateTime.fromMillisecondsSinceEpoch(
      e.endingTimeStamp,
    );
    final String formattedBeginDate = DateFormat('dd/MM/yyyy').format(begin);
    final String formattedEndDate = DateFormat('dd/MM/yyyy').format(end);
    final String formattedBeginTime = DateFormat('hh:mm:ss').format(begin);
    final String formattedEndTime = DateFormat('hh:mm:ss').format(end);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Starts on $formattedBeginDate',
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.green),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                'at $formattedBeginTime',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Ends on $formattedEndDate',
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.red),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Text(
                'at $formattedEndTime',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
