import 'package:aussie/models/event/event.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventCardImage extends StatelessWidget {
  const EventCardImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventModel e = Provider.of<EventModel>(context);
    return AspectRatio(
      aspectRatio: 1,
      child: Ink.image(
        image: CachedNetworkImageProvider(
          e.bannerImageLink,
        ),
      ),
    );
  }
}
