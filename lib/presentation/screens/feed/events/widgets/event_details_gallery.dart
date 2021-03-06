import 'package:aussie/presentation/widgets/aussie/aussie_photo_view.dart';
import 'package:aussie/util/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventDetailsGallery extends StatefulWidget {
  const EventDetailsGallery({
    Key? key,
  }) : super(key: key);

  @override
  _EventDetailsGalleryState createState() => _EventDetailsGalleryState();
}

class _EventDetailsGalleryState extends State<EventDetailsGallery>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final e = getEventModel(context);

    return ListView.builder(
      itemCount: e.galleryImages!.length,
      itemBuilder: (context, index) {
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AussiePhotoView(
                        url: e.galleryImages![index].imageLink,
                      );
                    },
                  ),
                );
              },
              child: CachedNetworkImage(
                imageUrl: e.galleryImages![index].imageLink!,
                fadeOutDuration: Duration.zero,
                progressIndicatorBuilder: (context, url, progress) {
                  return Center(
                    child: CircularProgressIndicator(value: progress.progress),
                  );
                },
                imageBuilder: (context, imageProvider) {
                  return Ink.image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  );
                },
              )),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
