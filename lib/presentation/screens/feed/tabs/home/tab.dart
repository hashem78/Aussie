import 'package:aussie/presentation/screens/feed/widgets/card.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FeedCard(),
        FeedCard(),
      ],
    );
  }
}
