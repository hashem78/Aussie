import 'dart:async';

import 'package:aussie/models/event/event.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/event_description_card.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/event_details_card_stack.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/event_details_gallery.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/paginated_attendees.dart';
import 'package:aussie/util/functions.dart';
import 'package:aussie/util/pair.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animations/loading_animations.dart';

class EventDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EventModel e = getEventModel(context);
    final image = _getImage(e.bannerImageLink);
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            FutureBuilder<Size>(
              future: image.second,
              builder: (BuildContext context, AsyncSnapshot<Size> snapshot) {
                Widget child = SliverAppBar(
                  expandedHeight: .2.sh,
                  collapsedHeight: .2.sh,
                  pinned: true,
                  title: Text(getTranslation(context, "eventDetailsTitle")),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Center(
                      child: LoadingBouncingGrid.square(),
                    ),
                  ),
                  bottom: const TabBar(
                    tabs: [
                      Icon(Icons.description),
                      Icon(Icons.attach_email_rounded),
                    ],
                  ),
                );

                if (snapshot != null) {
                  if (snapshot.hasData) {
                    child = SliverAppBar(
                      flexibleSpace: image.first,
                      expandedHeight: snapshot.data.height,
                      pinned: true,
                      title: Text(getTranslation(context, "eventDetailsTitle")),
                      bottom: const TabBar(
                        tabs: [
                          Icon(Icons.description),
                          Icon(Icons.attach_email_rounded),
                        ],
                      ),
                    );
                  }
                }

                return child;
              },
            ),
          ],
          body: const TabBarView(
            children: [
              EventDetailsMain(),
              PaginatedAtendees(),
            ],
          ),
        ),
      ),
    );
  }

  Pair<Image, Future<Size>> _getImage(String url) {
    final Completer<Size> completer = Completer();

    final ImageProvider image = CachedNetworkImageProvider(url);

    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          final myImage = image.image;
          final Size size = Size(
            myImage.width.toDouble(),
            myImage.height.toDouble(),
          );
          completer.complete(size);
        },
      ),
    );
    return Pair(Image(image: image, fit: BoxFit.cover), completer.future);
  }
}

class EventDetailsMain extends StatefulWidget {
  const EventDetailsMain({
    Key key,
  }) : super(key: key);

  @override
  _EventDetailsMainState createState() => _EventDetailsMainState();
}

class _EventDetailsMainState extends State<EventDetailsMain>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: EventCardStack()),
        buildTitle(context, getTranslation(context, "description")),
        const SliverToBoxAdapter(child: EventDetailsDescriptionCard()),
        buildTitle(context, getTranslation(context, "gallery")),
        const EventDetailsGallery(),
      ],
    );
  }

  SliverPadding buildTitle(BuildContext context, String text) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
