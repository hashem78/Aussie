import 'dart:math';

import 'package:aussie/models/event/event_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventCardImage extends StatelessWidget {
  const EventCardImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventModel e = Provider.of<EventModel>(context);
    return SizedBox(
      height: min(.5.sh, e.bannerImage.height.toDouble()),
      width: double.infinity,
      child: Ink.image(
        fit: BoxFit.fill,
        image: CachedNetworkImageProvider(
          e.bannerImage.imageLink,
        ),
      ),
    );
  }
}
