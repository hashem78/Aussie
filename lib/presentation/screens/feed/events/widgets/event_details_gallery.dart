import 'package:aussie/aussie_imports.dart';

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
    final EventModel e = getEventModel(context);

    return ListView.builder(
      itemCount: e.galleryImages!.length,
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
                        url: e.galleryImages![index].imageLink,
                      );
                    },
                  ),
                );
              },
              child: CachedNetworkImage(
                imageUrl: e.galleryImages![index].imageLink!,
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

  @override
  bool get wantKeepAlive => true;
}
