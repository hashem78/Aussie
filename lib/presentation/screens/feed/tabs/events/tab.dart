import 'package:aussie/presentation/screens/feed/tabs/events/widgets/card.dart';
import 'package:flutter/material.dart';

class EventsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        EventCard(),
      ],
    );
  }
}
