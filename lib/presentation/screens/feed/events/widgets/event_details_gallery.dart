import 'package:aussie/presentation/screens/feed/events/widgets/growing_image.dart';
import 'package:aussie/util/functions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

    return SliverToBoxAdapter(
      child: CarouselSlider(
        items: e.galleryImageLinks
            .map(
              (e) => Provider.value(
                value: e,
                child: GrowingImage(),
              ),
            )
            .toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          height: .6.sh,
          pageSnapping: true,
          enableInfiniteScroll: false,
          pageViewKey: PageStorageKey<String>("dgal-${e.uid}"),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
