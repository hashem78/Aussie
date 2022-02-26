import 'package:evento/presentation/widgets/aussie_photo_view.dart';
import 'package:evento/state/event_management.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventDetailsGallery extends ConsumerWidget {
  const EventDetailsGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final e = ref.watch(scopedEventProvider);

    final galleryImages = e.mapOrNull(remote: (val) => val.galleryImages)!;

    return ListView.builder(
      itemCount: galleryImages.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int index) {
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<AussiePhotoView>(
                    builder: (BuildContext context) {
                      return AussiePhotoView(
                        url: galleryImages[index].imageLink,
                      );
                    },
                  ),
                );
              },
              child: CachedNetworkImage(
                imageUrl: galleryImages[index].imageLink,
                fadeOutDuration: Duration.zero,
                progressIndicatorBuilder: (
                  BuildContext context,
                  String url,
                  DownloadProgress progress,
                ) {
                  return Center(
                    child: CircularProgressIndicator(value: progress.progress),
                  );
                },
                imageBuilder: (BuildContext context,
                    ImageProvider<Object> imageProvider) {
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
}
