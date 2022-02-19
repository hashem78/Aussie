import 'package:aussie/state/event_management.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventCardDescription extends ConsumerWidget {
  const EventCardDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final e = ref.watch(scopedEventProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
