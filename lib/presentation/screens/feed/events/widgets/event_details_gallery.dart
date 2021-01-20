import 'package:aussie/presentation/screens/feed/events/widgets/growing_image.dart';
import 'package:aussie/util/functions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetailsGallery extends StatefulWidget {
  const EventDetailsGallery({
    Key key,
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

    return CarouselSlider(
      items: e.galleryImages
          .map(
            (e) => Provider.value(
              value: e,
              child: GrowingImage(),
            ),
          )
          .toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        enableInfiniteScroll: false,
        pageViewKey: PageStorageKey<String>("dgal-${e.uid}"),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
