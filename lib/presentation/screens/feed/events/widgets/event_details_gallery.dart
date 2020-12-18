import 'package:aussie/presentation/screens/feed/events/widgets/growing_image.dart';
import 'package:aussie/util/functions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetailsGallery extends StatelessWidget {
  const EventDetailsGallery({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final e = getEventModel(context);

    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverToBoxAdapter(
        child: CarouselSlider(
          items: e.galleryImageLinks
              .map(
                (e) => Provider.value(
                  value: e,
                  child: Builder(builder: (_) => GrowingImage()),
                ),
              )
              .toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            height: .5.sh,
            pageSnapping: true,
            enableInfiniteScroll: false,
            pageViewKey: PageStorageKey<String>("dgal-${e.uid}"),
          ),
        ),
      ),
    );
  }
}
