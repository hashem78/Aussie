import 'package:aussie/state/event_management.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventDetailsDescriptionCard extends ConsumerWidget {
  const EventDetailsDescriptionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final e = ref.watch(scopedEventProvider);

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
