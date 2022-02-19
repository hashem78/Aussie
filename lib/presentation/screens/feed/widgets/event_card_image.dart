import 'package:aussie/state/event_management.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventCardImage extends ConsumerWidget {
  const EventCardImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final e = ref.read(scopedEventProvider);
    final bannerImage = e.mapOrNull(remote: (val) => val.bannerImage)!;
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CachedNetworkImage(
        imageUrl: bannerImage.imageLink,
        fit: BoxFit.fill,
        imageBuilder: (context, imageProvider) {
          return Ink.image(
            image: imageProvider,
          );
        },
        progressIndicatorBuilder: (context, String url, progress) {
          return Center(
            child: CircularProgressIndicator(value: progress.progress),
          );
        },
      ),
    );
  }
}
