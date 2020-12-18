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
      margin: EdgeInsets.zero,
      child: ExpandText(
        e.description,
        textAlign: TextAlign.center,
        expandOnGesture: false,
      ),
    );
  }
}
