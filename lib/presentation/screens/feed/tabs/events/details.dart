import 'package:aussie/constants.dart';
import 'package:aussie/presentation/screens/feed/tabs/events/widgets/event_details_card_stack.dart';
import 'package:aussie/presentation/screens/feed/tabs/events/widgets/growing_image.dart';
import 'package:aussie/presentation/screens/feed/widgets/card_owner.dart';
import 'package:aussie/presentation/screens/profile/widgets/banner.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverSafeArea(
            sliver: SliverAppBar(
              expandedHeight: .6.sh,
              primary: true,
              pinned: true,
              title: Text("Event"),
              flexibleSpace: BannerImage(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: EventCardStack(),
            ),
          ),
          buildTitle(context, "Description"),
          SliverToBoxAdapter(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandText(
                  klorem,
                  expandOnGesture: false,
                ),
              ),
            ),
          ),
          buildTitle(context, "Gallery"),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: CarouselSlider(
                items: [
                  GrowingImage(),
                  GrowingImage(),
                ],
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: .5.sh,
                  pageSnapping: true,
                  enableInfiniteScroll: false,
                ),
              ),
            ),
          ),
          buildTitle(context, "Attending"),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  CardOwner(),
                  CardOwner(),
                  CardOwner(),
                ],
              ),
            ),
          ),
        ],
      ),
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
}
