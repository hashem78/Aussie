import 'package:aussie/util/functions.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';

class EventDetailsDescriptionCard extends StatelessWidget {
  const EventDetailsDescriptionCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final e = getEventModel(context);

    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpandText(
          e.description,
          textAlign: TextAlign.center,
          expandOnGesture: false,
        ),
      ),
    );
  }
}
