import 'package:aussie/presentation/screens/feed/all_comments.dart';
import 'package:aussie/presentation/screens/feed/widgets/card_textfieild.dart';
import 'package:aussie/presentation/screens/feed/widgets/feed_card_image.dart';
import 'package:aussie/presentation/screens/feed/widgets/comment.dart';
import 'package:flutter/material.dart';

import 'card_owner.dart';

class FeedCard extends StatelessWidget {
  const FeedCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AllCommentsScreen();
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardOwner(),
              FeedCardImage(),
              FeedCardComment(),
              FeedCardTextField(),
            ],
          ),
        ),
      ),
    );
  }
}
