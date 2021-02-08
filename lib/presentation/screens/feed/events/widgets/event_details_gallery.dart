import 'package:aussie/presentation/widgets/aussie/aussie_photo_view.dart';
import 'package:aussie/util/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventDetailsGallery extends StatelessWidget {
  const EventDetailsGallery({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final e = getEventModel(context);

    return ListView.builder(
      itemCount: e.galleryImages.length,
      itemBuilder: (context, index) {
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AussiePhotoView(
                      url: e.galleryImages[index].imageLink,
                    );
                  },
                ),
              );
            },
            child: Ink.image(
              image: CachedNetworkImageProvider(
                e.galleryImages[index].imageLink,
              ),
            ),
          ),
        );
      },
    );
  }
}
