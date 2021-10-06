import 'package:aussie/models/event/event_model.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventCardImage extends StatelessWidget {
  const EventCardImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventModel e = Provider.of<EventModel>(context);
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CachedNetworkImage(
        imageUrl: e.bannerImage!.imageLink!,
        fit: BoxFit.fill,
        imageBuilder: (BuildContext context, ImageProvider<Object> imageProvider) {
          return Ink.image(
            image: imageProvider,
          );
        },
        progressIndicatorBuilder: (BuildContext context, String url, DownloadProgress progress) {
          return Center(
            child: CircularProgressIndicator(value: progress.progress),
          );
        },
      ),
    );
  }
}
